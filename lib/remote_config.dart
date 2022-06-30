import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class remoteConfig extends StatefulWidget {
  const remoteConfig({Key? key}) : super(key: key);

  @override
  _remoteConfigState createState() => _remoteConfigState();
}

class _remoteConfigState extends State<remoteConfig> {
  // Define background colors available for this app

  final String _defaultBannerText = "Try reloading";

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
          10), // fetch parameters will be cached for a maximum of 1 hour
    ));

    _fetchConfig();
  }

  // Fetching, caching, and activating remote config
  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    _initConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App details'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  const Text('App Name: '),
                  Text(
                    _remoteConfig.getString('appName').isNotEmpty
                        ? _remoteConfig.getString('appName')
                        : _defaultBannerText,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  const Text('Version: '),
                  Text(
                    _remoteConfig.getString('version').isNotEmpty
                        ? _remoteConfig.getString('version')
                        : _defaultBannerText,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  const Text('Base URL: '),
                  Text(
                    _remoteConfig.getString('BaseUrl').isNotEmpty
                        ? _remoteConfig.getString('BaseUrl')
                        : _defaultBannerText,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                      content: Text('Recorded Error'),
                      duration: Duration(seconds: 5),
                ));
                throw Error();
              } catch (e, s) {
                // "reason" will append the word "thrown" in the
                // Crashlytics console.
                await FirebaseCrashlytics.instance.recordError(e, s,
                    reason: 'as an example of non-fatal error');
              }
            },
            child: const Text('Record Non-Fatal Error'),
          ),
        ],
      ),
    );

  }
}