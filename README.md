# ![qloop](docs/icon.png) QLoop-Demo

[![build status](https://travis-ci.org/quickthyme/qloop-demo.svg?branch=master)](https://travis-ci.org/quickthyme/qloop)
![license](https://img.shields.io/github/license/quickthyme/qloop-demo.svg?color=black)

Demonstration using [QLoop](https://github.com/quickthyme/qloop)
for the implementation and testing of an iOS view controller using
declarative composition.

**Includes** *real-world* **examples** of:

  - observer pattern and reactive rendering
  - declarative chaining of asynchronous operations
  - basic dependency injection using InterfaceBuilder
  - managing background threads
  - handling errors
  - unit-testing solutions


<br />

## Getting Started

This application has a dependency on [qloop](https://github.com/quickthyme/qloop), which has been imported as a **git submodule**.
Whenever you clone or update from the source repository, don't forget to also update the submodule using:

```
git submodule update --init
```

<br />

#### Of particular interest

- You might notice that none of the application entities have any sort of
"hard" dependency on QLoop. Only those objects to which any loop construct
is bound (e.g. the view controller, its injector, and its tests) need to
import it.

- This is a very important aspect to QLoop's design, and why you should not
attempt to create subclasses of loops, segments, or anchors. Instead, you
should try and implement your operations generically, independent of each
other. Then have your `injector` or `delegate` compositionally attach the
operations to loop segments when creating a path.

- The separation of the loop from its path is important to note here. One of
QLoop's testing strengths stems from this feature, as it provides its own
sort of "natural" mocking mechanism. Because we use observer pattern here, we
can safely assign values to the inactive loop anchors, (without having to make
asynchronous calls), and then just verify the reactions.

- After loading the view from the storyboard in the test, we call `destroy()`
in order to return it to its natural state by removing all bound path segments.

<br />

Should you encounter any bugs or think it *needs* a particular feature,
feel free to open an [issue](https://github.com/quickthyme/qloop-demo/issues).
