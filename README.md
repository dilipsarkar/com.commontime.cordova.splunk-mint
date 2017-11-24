# Splunk Mint Plugin

The Splunk Mint plugin provides a way of integrating Splunk Mint crash reporting into a Cordova app. There are two ways of configuring and starting it: via the `config.xml` file, in which case Splunk Mint is started as soon as the plugin loads; and via a call to `plugins.splunkmint.start`, in which case, Splunk Mint won't be started until this call completes.

## Configuration via config.xml

There are 5 preferences available for configuration in the `config.xnl` file:

* `splunk_android_api_key`, which specifies the Splunk API key for Android.
* `splunk_ios_api_key`, which specifies the Splunk API key for iOS.

As alternative to the splunk cloud you can use your own HTTPEventCollector
* `splunk_hec_url`, which specifiy your url to your HTTPEventCollector
* `splunk_hec_url`, which specifiy your Token to access your HTTPEventCollector

And submit some extra data
* `splunk_extra_data`, which specifies any extra data to be uploaded in the event of a crash; this is a string representation of a JSON object whose values are all strings.

For example:

```xml
<preference name="splunk_android_key" value="f25257f1"/>
<preference name="splunk_ios_api_key" value="b2c251f8"/>
<preference name="splunk_hec_url" value="https://yourserver/services/collector/mint"/>
<preference name="splunk_hec_token" value="ljylfushfsjkhpo"/>
<preference name="splunk_extra_data" value="{'user': 'gary'}"/>
```

## Calls

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

### plugins.splunkmint.enableLogCat

Enables a limited logcat to be sent along with a crash. _Android only_.

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

Add a breadcrumb to a potential crash report.

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

Log an event.

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

Log a view.

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

Get the number of crashes since install. On iOS, this always returns `0`.

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

Gets the ID of the last crash or `null` if there wasn't one. On iOS, this always returns `null`.

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

Start a transaction with a given name.

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

Stop the transaction with the given name.

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

Cancel the transaction with the given name for the given reason.

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

Flush pending items.

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

Write a log message from a given source at a specified level. Valid levels are `"v"` (verbose), `"d"` (debug, the default), `"i"` (info), `"w"` (warning) and `"e"` (error). Note on iOS `"v"` is the same as `"w"` and the `tag` field is ignored.

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
  'priority': 'i'
};

plugins.splunkmint.log(successCallback, errorCallback, options);
```
