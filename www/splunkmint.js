var argscheck = require('cordova/argscheck'), exec = require('cordova/exec');

module.exports = {
  crash : function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'crash', []);
  },
  enableLogCat : function(successCallback, errorCallback, options) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'enableLogCat', [options]);
  },
  leaveBreadcrumb : function(successCallback, errorCallback, crumb) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'leaveBreadcrumb', [crumb]);
  },
  logEvent : function(successCallback, errorCallback, log) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'logEvent', [log]);
  },
  logView : function(successCallback, errorCallback, log) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'logView', [log]);
  },
  getTotalCrashesNum : function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'getTotalCrashesNum', []);
  },
  getLastCrashId : function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'getLastCrashId', []);
  },
  transactionStart : function(successCallback, errorCallback, name) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'transactionStart', [name]);
  },
  transactionStop : function(successCallback, errorCallback, name) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'transactionStop', [name]);
  },
  transactionCancel : function(successCallback, errorCallback, options) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'transactionCancel', [options]);
  },
  enableDebugLog : function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'enableDebugLog', []);
  },
  flush : function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'flush', []);
  },
  log : function(successCallback, errorCallback, options) {
    cordova.exec(successCallback, errorCallback, 'SplunkMint', 'log', [options]);
  }
}
