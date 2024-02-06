import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memory_game/core/utils/utils.dart';

import 'package:audioplayers/audioplayers.dart';

class AudioService {
  List<String> playList = [
    AppAssets.gameMusic1,
    AppAssets.gameMusic2,
    AppAssets.gameMusic3,
  ];
  int _currentSongIndex = 0;
  AudioPlayer? _musicPlayer;
  AudioPlayer? _foundSound;
  AudioPlayer? _notMatchSound;
  AudioPlayer? _winGameSound;
  bool _enabledInGameMusic = true;
  bool _enabledGameSounds = true;
  StreamSubscription? musicStreamSubscription;
  static final AudioService _instance = AudioService._();
  AudioService._();

  factory AudioService() {
    return _instance;
  }

  void getAudioServiceSettings(
      bool enabledInGameMusic, bool enabledGameSounds) {
    _enabledInGameMusic = enabledInGameMusic;
    _enabledGameSounds = enabledGameSounds;
  }

  void initAudioService() {
    if (_enabledInGameMusic) {
      initMusic();
    }

    if (_foundSound == null &&
        _notMatchSound == null &&
        _winGameSound == null) {
      _foundSound = AudioPlayer();
      _notMatchSound = AudioPlayer();
      _winGameSound = AudioPlayer();
    }
  }

  void initMusic() {
    _currentSongIndex = AppFunctions.getRandomNumber(playList.length - 1);
    _musicPlayer ??= AudioPlayer();
    initMusicStreamSubscription();
  }

  initMusicStreamSubscription() {
    if (_musicPlayer != null && musicStreamSubscription == null) {
      musicStreamSubscription = _musicPlayer!.onPlayerStateChanged.listen(
        (event) {
          debugPrint("$event");
          if (event == PlayerState.completed) {
            if (_currentSongIndex < 2) {
              _currentSongIndex = getRandomSong();
            } else {
              _currentSongIndex = 0;
            }
            playGameMusic();
          }
        },
      );
    }
  }

  int getRandomSong() {
    int randomIndex = AppFunctions.getRandomNumber(playList.length - 1);
    if (randomIndex == _currentSongIndex) {
      getRandomSong();
    }
    return randomIndex;
  }

  void playGameMusic() async {
    if (!_enabledInGameMusic && _musicPlayer == null) return;
    _musicPlayer?.setReleaseMode(ReleaseMode.release);
    _musicPlayer?.play(
      AssetSource(playList[_currentSongIndex]),
      mode: PlayerMode.mediaPlayer,
      volume: 0.4,
    );
  }

  void pauseMusic() {
    _musicPlayer?.pause();
  }

  void playFoundSound() async {
    if (!_enabledGameSounds) return;
    await _foundSound?.play(
      AssetSource(AppAssets.foundCards),
      mode: PlayerMode.mediaPlayer,
    );
  }

  void playNotMatchSound() async {
    if (!_enabledGameSounds) return;
    await _notMatchSound?.play(
      AssetSource(AppAssets.notMatchCards),
      mode: PlayerMode.mediaPlayer,
    );
  }

  void playWinningSound() async {
    if (!_enabledGameSounds) return;
    await _winGameSound?.play(
      AssetSource(AppAssets.winGame),
      mode: PlayerMode.mediaPlayer,
    );
  }

  void quitAllSounds() {
    _musicPlayer?.dispose().then((_) => _musicPlayer = null);
    _foundSound?.dispose().then((_) => _foundSound = null);
    _notMatchSound?.dispose().then((_) => _notMatchSound = null);
    _winGameSound?.dispose().then((_) => _winGameSound = null);
    if (musicStreamSubscription != null) {
      musicStreamSubscription!
          .cancel()
          .then((value) => musicStreamSubscription = null);
    }
  }

  void setInGameMusic() {
    if (_enabledInGameMusic) {
      _musicPlayer?.dispose().then((_) => _musicPlayer = null);
      musicStreamSubscription!
          .cancel()
          .then((_) => musicStreamSubscription = null);
    } else {
      if (_musicPlayer == null) {
        initMusic();
        playGameMusic();
      }
    }
    _enabledInGameMusic = !_enabledInGameMusic;
  }

  void setGameSounds() {
    _enabledGameSounds = !_enabledGameSounds;
  }
}
