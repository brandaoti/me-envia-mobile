fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## Android
### android testers
```
fastlane android testers
```
Submit a new Beta Build to Cubos' team
### android customers
```
fastlane android customers
```
Submit a new Beta Build to Atria's Customers
### android build_android
```
fastlane android build_android
```

### android deploy_android
```
fastlane android deploy_android
```
Deploy (Upload to play store)
### android prod
```
fastlane android prod
```
Promote Beta track to Production in Google Play

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
