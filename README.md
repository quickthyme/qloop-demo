# ![qloop](docs/icon.png) QLoop-Demo

[![build status](https://travis-ci.com/quickthyme/qloop-demo.svg?branch=master)](https://travis-ci.org/quickthyme/qloop)
![license](https://img.shields.io/github/license/quickthyme/qloop-demo.svg?color=black)

Demonstration using [QLoop](https://github.com/quickthyme/qloop)
for the implementation and testing of an iOS view controller using
declarative composition.

**Includes** *real-world* **examples** of:

  - observer pattern and reactive rendering
  - declarative chaining of asynchronous operations
  - basic dependency injection (binding) using InterfaceBuilder
  - utilizing background threads
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

- The view controller in this example is using an observer pattern. Here, we've placed
an empty loop in the view and added just the code that renders/updates the view whenever
input is received through either the `onChange(_:)` and/or `onError(_:)` events.

- You are not limited to using only one loop in this manner. An entity can have as many
loops as it needs for a variety of purposes.

- You should not attempt to create subclasses of loops, segments, or anchors.
Instead, you should try and implement your operations generically, independent
of each other. Then have your `injector`, `delegate`, `factory`, or whatever attach
the operations to segments when they're needed.

- At the start of our tests, after loading the view from the storyboard, we call
`destroy()` in order to return the loop to its natural, empty state.

- The separation of the loop from its path allows us to safely invoke its `input` and `output`
 however we wish. We can use synchronous unit testing techniques to verify our code's
 reactions.


<br />

Should you encounter any bugs or think it *needs* a particular feature,
feel free to open an [issue](https://github.com/quickthyme/qloop-demo/issues).
