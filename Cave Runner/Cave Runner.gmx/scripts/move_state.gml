///move_state90


//gravcheck
if(!place_meeting(x,y+1,Solid))
{
vspd+=grav;

//player in air
sprite_index= spr_player_jump;
image_speed=0;
image_index=(vspd>0);

//jump height control
   if(up_release && vspd<=-6)
   {
   vspd=-6;
   }
}
else
{
vspd=0;
  //jump on press
     if(up)
     {
     vspd=-16;
     audio_play_sound(snd_jump,5,false);
     }
  //player on ground
    if(hspd==0)
    {
    sprite_index=spr_player_idle;
    }
    else
    {
    sprite_index=spr_player_walk;
    image_speed=0.6;
    }
}

//check move


if(hspd !=0)
{
image_xscale = sign(hspd);
}


if(right||left)
{
   hspd+=(right-left)*acc;
   if(hspd>spd)
   {
   hspd=spd;
   }
   if(hspd<-spd)
   {
   hspd=-spd;
   }
}
else
{
//hspd=0;
apply_friction(acc);
}
//landing sound
if(place_meeting(x,y+vspd,Solid) && vspd>0)
{
audio_emitter_pitch(audio_em, random_range(.8,1.2));
audio_emitter_gain(audio_em,0.2);
audio_play_sound_on(audio_em,snd_step,false,6);
}
//move call
move(Solid);

//check for ledge grab
var falling = y-yprevious>0;
var wasnt_wall=!position_meeting(x+17*image_xscale,yprevious,Solid);
var is_wall=position_meeting(x+17*image_xscale,y,Solid);
if(falling && wasnt_wall && is_wall)
{
hspd=0;
vspd=0;
//move to ledge
   while(!place_meeting(x+image_xscale,y,Solid))
   {
   x+=image_xscale;
   }
//height check
   while(position_meeting(x+17*image_xscale,y-1,Solid))
   {
    y=y-1;
   }
   sprite_index=spr_player_ledge_grab;
   state=ledge_grab_state;
   //sound
   audio_emitter_pitch(audio_em,1.5);
   audio_emitter_gain(audio_em,.1);
   audio_play_sound_on(audio_em,snd_step,false,6);
}
