---
 layout:     post
 title:      Split Servo's script crate
 date:       2018-08-09 00:30:00
 summary:    Summary of separation Servo's script crate to smaller crates
 categories:
 ---
 
## Introduction

I am Peter Hrvola (retep007) [Twitter](https://twitter.com/retep007) [Github](https://github.com/retep007). During my GSoC project, I have been working on investigating the monolithic nature of Servo's script crate and prototyping separation to smaller crates. Our goal was to improve the use of resources during compilation. Current debug build consumes over 5GB of memory and takes 347s.

Our solution is based on structures in script crate beeing generic over *TypeHolder* which contains concrete types. Testing shows significant improvement in memory consumption (~3.7GB) and time (231s).

## The process

 For prototyping, we have been using two repositories. One with [minimal script crate](https://github.com/retep007/servo) which contains only a few WebIDLs. We used minimal script crate for investigating ideas before implementing them in full scale. The second repository contains [full servo fork](https://github.com/retep007/servo_1).

We have started to work on project very early. During community bonding period we wanted to make a few small pull requests to separate some isolated parts of script crate. As it turned out, there is no low hanging fruit in script crate. We have quickly encountered many unexpected issues, so we continuously moved to the original plan.

All original ideas for investigation can be found in [GSoC project proposal](https://storage.googleapis.com/summerofcode-prod.appspot.com/gsoc/core_project/doc/5703489939308544_1521985113_Servo__Prototype_ways_of_splitting_up_the_script_crate.pdf?Expires=1533631036&GoogleAccessId=summerofcode-prod%40appspot.gserviceaccount.com&Signature=YqnoZPNmnUH0nJypUnCWLD50wFqU8%2FnZOVO8ImlKmQY3RQM5d85Q5WFdOqABIUQIrhUTqo2clrVJcdG%2FFgZmSXC20ErWY4PV6FWSGwhuK3WgHBRAfjPn2iz4hdhwitnQdMCBpaL9bZRvvUJa%2BEZU1CxLLC8pwK6c8yF18YJKHddxuos7ackjhG7vLSuIvVvxfn419g3%2BEsfQPEpVOZbFugbXgGg2FBH7n7ZUeCj%2BTpEZrhnow7W%2Biu3pGinj536nA%2BqccssL5%2FdVyGHHsbEFXBoek%2B5IoyEqXA92Gh8ydp%2Fba%2Btv4CbxbRyzkasIrP2eemooyvv334WC7TOBetyUBw%3D%3D). However, during the first week of coding, we have experienced many issues and come up with something that is more or less combination of all three proposed ideas.

The biggest problem that caused most of the troubles and pain is that Rust at the time of doing this project did not support generic consts [RFC](https://github.com/rust-lang/rust/issues/44580). 

After two months of solving errors, we have been finally able to compile full servo and take some measurements about which I talk later in this blog post.

Original GSoC project assignment was to prototype ways of splitting script crate, but since results were quite promising and we had a month of coding left we started to prepare a PR to Servo master. During the prototyping period, we have made a few ugly hacks to speed up development. As a result, we had to modify CodeGen to generate generic Bindings and modify thread_local variables that needed to be generic. 

## How it works

The final idea of separation is based on using the *TypeHolderTrait*. TypeHolderTrait is a trait with type parameters for every WebIDL interface that we want to move outside of the script crate. *TypeHolderTrait* itself is defined in script crate with all type parameter traits. However, it is implemented outside of the script crate so it can provide concrete types. TypeHolder enables us to use constructs like static methods in script crate. Later, we use TypeHolder as type parameter for structs and methods that require access to external types. *TypeHolderTrait* might look like:

```rust
trait TypeHolderTrait {
    type DomParser: DomParserTrait<Self>
}

```

````rust
trait DOMParserTrait<TH: TypeHolderTrait>: MutDomObject + IDLInterface + MallocSizeOf + JSTraceable + DOMParserMethods<TH> {
    fn Constructor(window: &Window<TH>) -> Fallible<DomRoot<TH::DOMParser>>;
}

````

IDLTraits usually have only a few functions.

## Effects on Servo

Modifications in final PR should have only minimal effects on Servo speed. However, the codebase has undergone big surgery 🏥. With about 12000 modified line. The most intrusive change is to use TypeHolder where it is required. It turns out that TypeHolder is needed in a lot of places. Leading cause of such a large number of changes is mainly *GlobalScope* which is used all around the codebase and needs to be generic.

Due to lack of Rust support for generic static variables at many places we had to modify the code to use initialization methods to fill static variables. For example, in Bindings, we have added an *InitTypeHolded* function which replaces the content of mutable static variables with appropriate function calls. This pattern was used with the *build.rs* script and also thread locals.

## Speeeeed 🚀

I have done testing on MacBook Pro 2015, High Sierra, 2,7 GHz i5 dual core, 16 GB RAM using `/usr/bin/time`, which shows maximal memory usage during compilation.

Resources were measured in this way:

1. compile full servo
2. modify Attr.rs file and ServoParser.rs file (after separation they are in different crates)
3. measure resources used to build a full servo

|           | Generic Servo | Servo without modification |
| --------- | ------------- | -------------------------- |
| RAM       | 3.74GB        | 5.1GB                      |
| Real time | 231s          | 347s                       |

As we can see in the table above, resource usage during compilation has drastically changed. The main reason is that because of a large number of generic structures which postpone parts of compilation to later monomorphization. In future, actual separation of dom structs to upstream crates will lower this number even more. In the current version, only six dom_structs were moved outside the script crate.

## Future work

At the time of writing this post, there is still continuous work on modifying generic Servo before creating a PR.

Thinks left to be done:

1. Fix tests
2. Performance optimization
3. Polish PR

## Important links

- [Pull request to Servo](https://github.com/servo/servo/pull/21371)
- [GSoC project](https://summerofcode.withgoogle.com/serve/5065009403527168/)
- [Document with TypeHolder idea](https://paper.dropbox.com/doc/Script-Trait-types--AJwd82loCgoigvnx2NGK7G1mAQ-BKKNiTpqoTSvd502snFlu)

## Conclusion

Working on a project for two months without successful compilation and having compiler yelling that you have made 34174 mistakes is a bit scary. However, they say that the more mistakes you make, the more you learn. I guess I have made a lot of mistakes and I have learned a ton as we have constantly been pushing the Rust-lang to its limits in large Servo codebase. All in all, this was an awesome project, and I enjoyed it very much.

I would like to thank my mentor [Josh Bowman-Matthews (jdm)](https://twitter.com/lastontheboat) for this opportunity. It was such a pleasure to work with him.
