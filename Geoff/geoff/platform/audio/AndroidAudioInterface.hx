package geoff.platform.audio;
import geoff.audio.AudioChannel;
import geoff.audio.AudioInterface;
import geoff.audio.AudioMixer;

import android.media.AudioTrack;
import android.media.AudioFormat;
import android.media.AudioManager;

import java.nio.ByteBuffer;

/**
 * ...
 * @author Simon
 */
class AndroidAudioInterface extends AudioInterface
{
	
	var _track : AudioTrack;

	public function new() 
	{
	}
		
	override public function init():Void 
	{
		super.init();
		_track = new AudioTrack( AudioManager.STREAM_MUSIC, 44100, AudioFormat.CHANNEL_OUT_STEREO, AudioFormat.ENCODING_PCM_16BIT, 4096, AudioTrack.MODE_STREAM );
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		_track.release();
	}
	
	override public function update( seconds : Float ):Void 
	{
		trace( _track.getPlaybackHeadPosition(), _track.getPlayState(), AudioTrack.PLAYSTATE_PLAYING );
		
		super.update( seconds );
		bufferData();
		
		if ( _track.getPlayState() != AudioTrack.PLAYSTATE_PLAYING ) 
		{
			_track.play();
		}
	}
	
	override public function bufferData():Void 
	{
		super.bufferData();
		
		_track.write( mixer.getBufferData().getData(), 0, 4096 );
		_track.flush();
		
	}
	
}