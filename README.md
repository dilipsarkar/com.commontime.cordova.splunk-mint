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

_This function is used purely for testing — do NOT use in a released app_. On iOS, it will crash the app with a segmentation violation (SIGSEGV). When the app is restated, an error report should be uploaded to the Splunk Mint website.

```javascript
function successCallback () {
  // This will never be called 'cos we'll already have crashed
}

function errorCallback (message) {
  // See above
}

plugins.splunkmint.crash(successCallback, errorCallback)
```

## Android only calls

### plugins.splunkmint.enableLogCat

Enables a limited logcat to be sent along with a crash.

```javascript
function successCallback () {
  // Enabled
}

function errorCallback (message) {
  // There was a problem
}

var options = {
  'enable': true,	// required
  'loglines': 100,	// optional
  'filter': 'ActivityManager:I MyApp:D *:S' // optional
};

plugins.splunkmint.enableLogCat(successCallback, errorCallback, options);
```

### plugins.splunkmint.leaveBreadcrumb

Add a breadcrumb to a potential crash report

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.leaveBreadcrumb(successCallback, errorCallback, "opened page 2");
```

### plugins.splunkmint.logEvent

Log an event

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.logEvent(successCallback, errorCallback, "Logged in");
```

### plugins.splunkmint.logView

Log an view

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.logView(successCallback, errorCallback, "View X");
```

### plugins.splunkmint.getTotalCrashesNum

Get the number of crashes since install

```javascript
function successCallback (value) {
  console.log(value + ' crashes');
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.getTotalCrashesNum(successCallback, errorCallback);
```

### plugins.splunkmint.getLastCrashID

Log an view

```javascript
function successCallback (crashId) {
  console.log('Crash ID: ' + crashId);
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.getLastCrashID(successCallback, errorCallback);
```

### plugins.splunkmint.transactionStart

Start a transaction

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.startTransaction(successCallback, errorCallback, "RequestX");
```

### plugins.splunkmint.transactionStop

Stop a transaction

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.transactionStop(successCallback, errorCallback, "RequestX");
```

### plugins.splunkmint.transactionCancel

Cancel a transaction

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

var options = {
  'name': 'RequestX',
  'reason': 'UserCancelled'
};

plugins.splunkmint.transactionCancel(successCallback, errorCallback, options);
```

### plugins.splunkmint.flush

Flush pending items

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.flush(successCallback, errorCallback);
```

### plugins.splunkmint.enableDebugLog

Enable debug logging

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

plugins.splunkmint.enableDebugLog(successCallback, errorCallback);
```

### plugins.splunkmint.log

Enable debug logging

```javascript
function successCallback () {
  // done
}

function errorCallback (message) {
  // There was a problem
}

var options = {
  'tag': 'MyApp',
  'msg': 'Started loading screen...',
  'lvl': 'i'
};

plugins.splunkmint.log(successCallback, errorCallback, options);
```
