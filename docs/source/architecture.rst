Architecture
============

BLoc pattern
------------
The architecture of this application is based on the BLoC (Business Logic Component) pattern, which represents a way of separating the business logic from the presentation.

It uses Reactive Programming by sending and receiving streams of data based on events in order to decompose the application into independent components that can be easily tested and reused.

.. graphviz:: _static/graphs/architecture.dot


API
---

- Get Events for day: ``https://fiwis.fiw.fhws.de/fiwis2/api/events?day={{DAY}}``
- Get Events for today: ``https://fiwis.fiw.fhws.de/fiwis2/api/events/today``
- Get Event information by id: ``https://fiwis.fiw.fhws.de/fiwis2/api/events/{{ID}}``

- Get lecture information: ``https://fiwis.fiw.fhws.de/fiwis2/api/classes?q={{class name}}``



