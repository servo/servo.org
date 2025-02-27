---
layout:     post
tags:       blog
title:      "Servo Security Report: findings and solutions"
date:       2025-02-26
summary:    "Radically Open Security has performed a security audit on the Servo project."
---

The Servo project has received several grants from [**NLnet Foundation**](https://nlnet.nl/), and as part of these grants, NLnet offers different [support services](https://nlnet.nl/NGI0/services/). These services include security audits from [**Radically Open Security**](https://radicallyopensecurity.com/).

In one of our projects with NLnet, we were working on [adding support for **CSS floats** and **tables**](https://nlnet.nl/project/Servo/) in Servo. Once the project was completed, we reached out to Radically Open Security to run a security audit. The focus of the audit was in the code related to that project, so the main components investigated were the CSS code paths in the layout engine and Stylo. As part of this audit, four vulnerabilities were identified:

| ID | Type | Description | [Threat level](http://www.pentest-standard.org/index.php/Reporting) |
|---|---|---|---|
| `CLN-009` | Third-Party Library Vulnerability | Servo uses an outdated version of the time crate that is vulnerable to a known issue. | Moderate |
| `CLN-004` | Arithmetic underflow | By calling methods on a TableBuilder object in a specific order, an integer underflow can be triggered, followed by an attempted out-of-bounds access, which is caught by Rust, resulting in a panic. | Low |
| `CLN-002` | Arithmetic underflow | An arithmetic underflow condition is currently impossible to trigger, but may become accessible as its surrounding logic evolves. | N/A |
| `CLN-007` | Unguarded casting | Casting from an unsigned platform pointer-width integer into a fixed-width signed integer may result in erroneous layouts. | N/A |

If you want to know more details you can read the [**full report**]({{ '/files/ngie-servo-penetration-test-report-2024-1.0.pdf' | url }}).

The first issue (`CLN-009`) was related to a known vulnerability in version 0.1 of the `time` crate that Servo depended on ([`RUSTSEC-2020-0071`](https://rustsec.org/advisories/RUSTSEC-2020-0071)). We had [removed this in most of Servo](https://github.com/servo/servo/pulls?q=is%3Apr+merged%3A%3E%3D2023-10-26+in%3Atitle++%28+%22time%400.1%22+OR+%22legacy+time%22+OR+%22time+crate%22+OR+%22stop+using+time%22+OR+%22std%3A%3Atime%22+%29+), but there was one remaining dependency in WebRender. We have since addressed this vulnerability by removing it from the version of WebRender used in Servo ([@mrobinson](https://github.com/mrobinson), [#35325](https://github.com/servo/servo/pull/35325)), and we will also try to upstream our changes so that Firefox is unaffected.

We have also fixed the second (`CLN-004`) and third (`CLN-002`) issues by making the affected code more robust ([@Loirooriol](https://github.com/Loirooriol), [#34247](https://github.com/servo/servo/pull/34247), [#35437](https://github.com/servo/servo/pull/35437)), in the event web content can trigger them.

The fourth issue (`CLN-007`) is not urgent, since the values are constrained elsewhere and it would otherwise only affect layout correctness and not security, but it’s worth fixing at some point too.

Servo has long been highlighted for being **a memory-safe and concurrency-safe web rendering engine**, thanks to the guarantees provided by the Rust programming language, including its ownership system, borrow checker, and built-in data structures that enable safe concurrent programming. These features help prevent memory and concurrency vulnerabilities, such as use-after-free bugs and data races.

We find it promising that this security audit, although smaller and of limited scope, **identified no severe vulnerabilities**, especially none of that nature, and that we were able to address any vulnerabilities identified. This was a positive experience for Servo and the web, and we're keen to explore more security auditing for Servo in the future.

Thanks to the folks at [Radically Open Security](https://radicallyopensecurity.com/) for their work on this audit, and [NLnet Foundation](https://nlnet.nl/) for continuously supporting the Servo project.

