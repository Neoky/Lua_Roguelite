---------------
--File: music.lua
--
--Description:
--  This file loads the background music into the game
---------------

tracks = {
	"audio/150413_Been_Thru_It_All---free_download.mp3",
	"audio/150413_Hit_And_Run---free_download.mp3",
	"audio/150413_Septic_Mind---free_download.mp3",
	"audio/150413_Serial_Killer---free_download.mp3",
	"audio/150413_Success_As_One---free_download.mp3",
	"audio/150413_Wrath_Of_Sin---free_download.mp3"
}

-- setVolume must come before audio.play
-- I've also set background music to be on Channel 1.
audio.setVolume( 0.2, {channel=1} )
function changeTrack()
	local backgroundMusic = audio.loadStream( tracks[math.random(1,6)] )
	local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=1000, onComplete=changeTrack } )
end
changeTrack()