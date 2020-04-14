import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart' as ac;

//TODO shop for other audio tools to see if better performance can be found

/// Handles audio caching and functions.
class AudioCache {
  final ac.AudioCache _audioCache = ac.AudioCache(prefix: 'audio/');

  /// Override the default subdirectory for audio files.
	/// Must specify a path underneath `assets/` (or set to empty for `assets/` root).
	/// Default: `audio/`.
	///
	/// `assets/` limitation due to AudioPlayers plugin.
  void setSubPath(String subPath) {
  	_audioCache.prefix = subPath;
	}

  /// Plays a single run of the given file (takes an optional volume parameter).
  Future<AudioPlayer> play(String filename, {volume = 1.0}) {
    return _audioCache.play(filename, volume: volume, mode: PlayerMode.LOW_LATENCY);
  }

  /// Continuous looping of the given file (takes an optional volume parameter).
  Future<AudioPlayer> loop(String filename, {volume = 1.0}) {
    return _audioCache.loop(filename, volume: volume, mode: PlayerMode.LOW_LATENCY);
  }

  /// Plays a single run of the given file (takes an optional volume parameter).
  /// This method supports long audio files.
  Future<AudioPlayer> playLongAudio(String filename, {volume = 1.0}) {
    return _audioCache.play(filename, volume: volume);
  }

  /// Continuous looping of the given file (takes an optional volume parameter).
  /// This method supports long audio files.
  ///
  /// NOTE: Long audio files on Android have an audio gap between loop iterations.
	/// This happens due to limitations on Android's native media player features.
	/// If you need a gapless loop, prefer the `loop()` method.
  Future<AudioPlayer> loopLongAudio(String filename, {volume = 1.0}) {
    return _audioCache.loop(filename, volume: volume);
  }

  /// Loads a single file into the cache.
  Future<File> load(String filename) {
    return _audioCache.load(filename);  //TODO what, exactly, is this File return? and why?
  }

  /// Loads a List of files into the cache.
  Future<List<File>> loadAll(List<String> filenames) {
    return _audioCache.loadAll(filenames);
  }

  /// Removes a single audio file, by filename, from the cache.
  void remove(String filename) {
    _audioCache.clear(filename);
  }

  /// Clears all data from the cache.
  void clear() {
    _audioCache.clearCache();
  }

  /// Disables audio logging.
  void disableLog() {
    _audioCache.disableLog();
  }
}
