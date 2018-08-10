---
 layout:     post
 title:      GSoC wrap-up: Splitting Servo's script crate
 date:       2018-08-09 00:30:00
 summary:    A summary of the work to separate one very large crate into smaller ones
 categories:
 ---
 
## Introduction

I am Peter Hrvola (retep007) [Twitter](https://twitter.com/retep007) [Github](https://github.com/retep007). During my Google Summer of Code (GSoC) project, I have been working on investigating the monolithic nature of Servo's script crate and prototyping separation to smaller crates. My goal was to improve the use of resources during compilation. Current debug build consumes over 5GB of memory and takes 347s.

The solution introduces a *TypeHolder* trait which contains associated types, and makes many structures in the script crate generic over this new trait. This allows the generic structs to refer to the new trait's associated types, while the actual concrete types can be extracted into a separate crate. Testing shows significant improvement in memory consumption (25% lower) and build time (27% faster).

## The process

For prototyping, I have been using two repositories. One contains a stripped-down, [minimal script crate](https://github.com/retep007/servo) with only a few implementations of complex script types and no build-time code generation. This minimal script crate was used to investigate ideas. The second repository is a [complete fork](https://github.com/retep007/servo-1) of the entire Servo repository to ensure that the ideas could actually work in Servo itself.

I have started to work on project very early. During community bonding period I wanted to make a few small pull requests to separate some isolated parts of script crate. As it turned out, there is no low hanging fruit in script crate. I have quickly encountered many unexpected issues, so I continuously moved to the original plan.

All original ideas for investigation can be found in [GSoC project proposal](https://docs.google.com/document/d/1uZDmzuQZM4dTklR3ksrAnMgCWCkfJjtRl-rbQ7-54Gc/edit?usp=sharing). However, during the first week of coding, I have experienced many issues and come up with something that is more or less a combination of all three proposed ideas.

The biggest problem that caused most of the troubles and pain is that Rust at the time of doing this project did not support generic consts [RFC](https://github.com/rust-lang/rust/issues/44580). 

After two months of solving errors, I have been finally able to compile full servo and take some measurements about which I talk later in this blog post.

The original GSoC project assignment was to prototype ways of splitting script crate, but since results were quite promising and I had a month of coding left I started to prepare a PR to Servo master. During the prototyping period, I have made a few ugly hacks to speed up development. To properly fix these hacks, I needed to modify the [build-time code generation](https://github.com/servo/servo/pull/21371/files#diff-60d01595cff328c165842fea9e4ccbc2) to generate generic code that used the TypeHolder trait, as well as find replacements for [thread local variables](https://github.com/servo/servo/pull/21371/files#diff-6c9eb9831bece73e53b647b302e4f9b8) that needed to store generic values. 

## How it works

The final idea of separation is based on using the [TypeHolderTrait](https://github.com/servo/servo/pull/21371/files#diff-12c9bc2e114f0cc3677b5a3b11349eaf). TypeHolderTrait is a trait with type parameters for every WebIDL interface that we want to extract from the script crate. *TypeHolderTrait* itself is defined in script crate with all type parameter traits. However, it is [implemented](https://github.com/servo/servo/pull/21371/files#diff-3092ed761ed8d9f72f5f0298b15b77d8R142) outside of the script crate so it can provide concrete types. TypeHolder enables us to use constructs like static methods in script crate. Later, we use TypeHolder as type parameter for structs and methods that require access to external types. Let's have origial dom struct like DOMParser:
```rust
struct DOMParser {
    fn new_inherited(window: &Window) -> DOMParser {} 

    fn new(window: &Window) -> DomRoot<DOMParser> {}

    pub fn Constructor(window: &Window) -> Fallible<DomRoot<DOMParser>> {}
}
```

This struct definition is removed from *script* crate. The DOMParserTrait with public methods is created and added as associated type to *TypeHolderTrait* which can than be used in place of original DOMParser type.

```rust
trait TypeHolderTrait {
    type DomParser: DomParserTrait<Self>
}


trait DOMParserTrait<TH: TypeHolderTrait>: DOMParserMethods<TH> {
    fn Constructor(window: &Window<TH>) -> Fallible<DomRoot<TH::DOMParser>>;
}

````

## Effects on Servo

Modifications in final PR should have only minimal effects on Servo speed. However, the codebase has undergone big surgery: over 12000 modified lines 🏥! The most intrusive change is to use TypeHolder where it is required. It turns out that TypeHolder is needed in a lot of places. Leading cause of such a large number of changes is mainly *GlobalScope* which is used all around the codebase and needs to be generic.

Due to lack of Rust support for generic static variables at many places I had to modify the code to use initialization methods to fill static variables early during program initialization. For example, in Bindings, I have added an *InitTypeHolded* function which replaces the content of mutable static variables with appropriate function calls.

## Speeeeed 🚀

I have done testing on MacBook Pro 2015, High Sierra, 2,7 GHz i5 dual core, 16 GB RAM using `/usr/bin/time cargo build`, which shows maximal memory usage during compilation. Results may vary depending on build machine.

Cargo recompiles only crates that have been modified and crates that depend on modified crates. I have separated script crate to script and script_servoparser. We have taken three samples. One for original Servo. Two after separation I have made. For separated script crate compilation times were measured for each crate separately. Only one crate was modified at a time. However, change in script crate also forces recompilation of script_servoparser.

Resources were measured in this way:

1. compile full servo
2. modify files
3. measure resources used to build a full servo

Unchanged Servo:

|           | Servo |
| --------- | ------------- |
| RAM       | 5.1GB | 
| Real time | 3:49m |

Servo after separation to two crates:

| | Modified script crate | Modified script_servoparser crate |
| - | - | - |
| RAM | 3.74 GB | 2 GB |
| Real time | 2:56m | 1:48m |

As we can see in the table above, resource usage during compilation has drastically changed. The main reason is that because of a large number of generic structures which postpone parts of compilation to later monomorphization. In future, actual separation of dom structs to upstream crates will lower this number even more. In the current version, only six dom structs were moved outside the script crate.

## Future work

At the time of writing this post, there is still continuous work on modifying generic Servo before creating a PR.

Things left to be done:

1. Fix tests
2. Performance optimization
3. Polish PR

## Important links

- [Pull request to Servo](https://github.com/servo/servo/pull/21371)
- [GSoC project proposal](https://docs.google.com/document/d/1uZDmzuQZM4dTklR3ksrAnMgCWCkfJjtRl-rbQ7-54Gc/edit?usp=sharing))
- [Document with TypeHolder idea](https://paper.dropbox.com/doc/Script-Trait-types--AJwd82loCgoigvnx2NGK7G1mAQ-BKKNiTpqoTSvd502snFlu)

## Conclusion

Working on a project for two months without successful compilation and having compiler yelling that you have made 34174 mistakes is a bit scary. However, they say that the more mistakes you make, the more you learn. I guess I have made a lot of mistakes and I have learned a ton as I have constantly been pushing the Rust-lang to its limits in large Servo codebase. All in all, this was an awesome project, and I enjoyed it very much.

I would like to thank my mentor [Josh Bowman-Matthews (jdm)](https://twitter.com/lastontheboat) for this opportunity. It was such a pleasure to work with him.
