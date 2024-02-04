import 'package:audioplayers/audioplayers.dart';
import 'package:memory_game/core/utils/utils.dart';

class AudioService {
  AudioPlayer? _musicPlayer;
  AudioPlayer? _foundSound;
  AudioPlayer? _notMatchSound;
  AudioPlayer? _winGameSound;
  bool _enabledInGameMusic = true;
  bool _enabledGameSounds = true;
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
    if (_enabledInGameMusic && _musicPlayer == null) {
      _musicPlayer = AudioPlayer();
    }
    if (_enabledGameSounds &&
        (_foundSound == null &&
            _notMatchSound == null &&
            _winGameSound == null)) {
      _foundSound = AudioPlayer();
      _notMatchSound = AudioPlayer();
      _winGameSound = AudioPlayer();
    }
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

  void playGameMusic() async {
    if (!_enabledInGameMusic) return;
    _musicPlayer?.setReleaseMode(ReleaseMode.loop);
    _musicPlayer?.play(
      AssetSource(AppAssets.gameMusic2),
      mode: PlayerMode.mediaPlayer,
      volume: 0.4,
    );
  }

  void pauseMusic() {
    _musicPlayer?.pause();
  }

  void quitAllSounds() {
    _musicPlayer?.dispose();
    _foundSound?.dispose();
    _notMatchSound?.dispose();
    _winGameSound?.dispose();
  }

  void setInGameMusic() {
    if (_enabledInGameMusic) {
      _musicPlayer?.stop();
    } else {
      _musicPlayer?.resume();
    }
    _enabledInGameMusic = !_enabledInGameMusic;
  }

  void setGameSounds() {
    _enabledGameSounds = !_enabledGameSounds;
  }
}
