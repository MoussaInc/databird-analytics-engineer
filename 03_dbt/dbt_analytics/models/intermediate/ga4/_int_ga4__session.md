{% docs int_ga4__session %}

This model aggregates Google Analytics 4 events at the session level.
The model combines multiple events belonging to the same session in order to calculate session engagement metrics and traffic information.

Main metrics and information included in this model:
- **Session Duration**: Total duration of the session in seconds.
- **Pages Viewed**: Number of page views during the session.
- **Event Count**: Total number of events recorded during the session.
- **Session Start Time**: Timestamp of the first event in the session.
- **Session End Time**: Timestamp of the last event in the session.
- **Browser Used**: Browser used by the visitor during the session.
- **Traffic Source**: Source of the traffic (e.g. Google, Facebook).
- **Traffic Medium**: Marketing channel used to acquire the session (e.g. organic, cpc).
- **Campaign Name**: Marketing campaign associated with the session.

The model keeps only sessions with a duration greater than or equal to 30 seconds in order to focus on engaged user sessions.
This model is mainly used for web analytics, traffic analysis, marketing attribution, and user engagement reporting.

{% enddocs %}