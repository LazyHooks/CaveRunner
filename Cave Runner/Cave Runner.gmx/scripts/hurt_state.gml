///hurt_state

//set sprite
sprite_index=spr_player_hurt;

if(hspd!=0) image_xscale=sign(hspd);

//gravity
if(!place_meeting(x,y+1,Solid))
{
vspd+=grav;
}
else
{
vspd=0;
apply_friction(acc);
}

direction_move_bounce(Solid);

//revert to normal
if(hspd==0 && vspd==0)
{
image_blend=c_white;
if(PlayerStats.hp<=0)
{
PlayerStats.sapphires=0;
PlayerStats.hp=PlayerStats.maxhp;
if(audio_is_playing(snd_boss_music)) audio_stop_sound(snd_boss_music);
room_restart();
}
state=move_state;
}
