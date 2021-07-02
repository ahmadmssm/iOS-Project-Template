# Intro:
This service is used to log events from different third-party analytics loggers like Firebase, Facebook, etc...

## Steps:

1. Add your logging strategy in `AnalyticsStrategy`
2. Implement the `AnalyticsService` and link it with the `AnalyticsStrategy`
3. Add new event in `AnalyticsEvents`
4. Log with all the provided services.
```
func log(event: AnalyticsEvents) {
    let analyticsService: AnalyticsWithStrategyService = AnalyticsService()
    analyticsService.log(event: event)
}
```
5. Log with a specific service.
```
func logWithStrategy(event: AnalyticsEvents) {
    let firebaseAnalytics: AnalyticsService = FirebaseAnalyticsService.create()
    let analyticsService: AnalyticsWithStrategyService = AnalyticsService(analyticsServices: firebaseAnalytics)
    analyticsService.log(event: event, strategies: .firebase)
}
```
