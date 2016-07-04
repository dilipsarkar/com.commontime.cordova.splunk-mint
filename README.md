# Splunk Mint Plugin

The Splunk Mint plugin provides a way of integrating Splunk Mint crash reporting into a Cordova app. There are two ways of configuring and starting it: via the `config.xml` file, in which case Splunk Mint is started as soon as the plugin loads; and via a call to `plugins.splunkmint.start`, in which case, Splunk Mint won't be started until this call completes.

## Configuration via config.xml

There are two preferences available for configuration in the `config.xnl` file:

* `splunk_api_key`, which specifies the Splunk API key
* `splunk_extra_data`, which specifies any extra data to be uploaded in the event of a crash; this is a string representation of a JSON object whose values are all strings.

For example:

```xml
<preference name="splunk_api_key" value="b2c251f8"/>
<preference name="splunk_extra_data" value="{'user': 'gary'}"/>
```

## Calls

### plugins.splunkmint.start

This configures Splunk Mint and starts a new session. The configuration data is similar as that used in the `config.xml` file. The `extraData` parameter is optional.

```javascript
function successCallback () {
  // Splunk Mint was succesfully started
}

function errorCallback (message) {
  // Splunk Mint could not be started
}

var apiKey = 'b2c251f8'
var extraData = {'user': 'gary'}

plugins.splunkmint.start(successCallback, errorCallback, apiKey, extraData)
```

### plugins.splunkmint.crash

_This function is used purely for testing — do __not__ use in a released app_. On iOS, it will crash the app with a segmentation violation (SIGSEGV). When the app is restated, an error report should be uploaded to the Splunk Mint website.

```javascript
function successCallback () {
  // This will never be called 'cos we'll already have crashed
}

function errorCallback (message) {
  // See above
}

plugins.splunkmint.crash(successCallback, errorCallback)
```
