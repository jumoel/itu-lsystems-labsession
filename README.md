# L-System to (ACS)Logo Compiler

A simple ruby class that takes a simple grammar, axiom, a turning angle, a
start point and a drawing distance and outputs a
[ACSLogo](http://www.alancsmith.co.uk/logo/) program text.

* Grammar: A hash of `<symbol> => <expansion>`, such as `F => F-F+F+FF-F-F+F`.
* Axiom: A string representing the starting state, such as `F+F+F+F`.
* Angle: The number of degrees each turn is
* Start: The starting position in the form `"[x y]"`


## Usage:

    iterations = 4
    LToLogo.new(a[:grammar], a[:axiom], a[:angle], a[:start]).expand(iterations).compile()


## Limitations

At the moment, the compiler only understands the following symbols:

* `F`: Move *drawdistance* forward and draw
* `f`: Move *drawdistance* forward without drawing
* `+`: Turn *angle* degrees left
* `-`: Turn *angle* degrees right
* `[`: Save the current position and heading on the stack
* `]`: Restore the position and heading from the top of the stack


## Problems

ACSLogo can't really handle the programs as they get quite large.


## Examples

![](https://raw.github.com/jmoeller/itu-lsystems-labsession/master/tree.png)

**Plant-like structure**. Grammar: `F => F[-F]F[+F]F[F]`. Axiom: `F`. Angle: 30. Iterations: 4.

---

![](https://raw.github.com/jmoeller/itu-lsystems-labsession/master/koch.png)

**Quadratic Koch Island**. Grammar: `F => F-F+F+FF-F-F+F`. Axiom: `F+F+F+F`. Angle: 90. Iterations: 3.
