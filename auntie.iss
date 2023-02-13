/*
Flora
stifle

Name: Curse of Ill Intent BackDropIconID: 127 MainIconID: 3 Duration: 59.000000 MaxDuration: 60.000000 CurrentIncrements: 0 Description:
Name: Curse of the Spoken Word BackDropIconID: 495 MainIconID: 442 Duration: 58.000000 MaxDuration: 60.000000 CurrentIncrements: 0 Description:
Name: Curse of Lost Voices BackDropIconID: 316 MainIconID: 853 Duration: 59.000000 MaxDuration: 60.000000 CurrentIncrements: 0 Description:
Name: Curse of the Wanderer BackDropIconID: 317 MainIconID: 55 Duration: 59.000000 MaxDuration: 60.000000 CurrentIncrements: 0 Description:

Name: Magic Dusting BackDropIconID: 315 MainIconID: 227 Duration: 35.000000 MaxDuration: 36.000000 CurrentIncrements: 0 Description:
Name: Noxious Spores BackDropIconID: 315 MainIconID: 197 Duration: 35.000000 MaxDuration: 36.000000 CurrentIncrements: 0 Description:

Name -> Cell of the Wanderer
Loc -> 443.511078,108.739929,272.808563

Name -> Cell of Ill Intent
Loc -> 442.726166,109.709114,132.173203

Name -> Cell of the Spoken Word
Loc -> 463.217224,109.906990,258.667053

Name -> Cell of Lost Voices
Loc -> 397.068054,109.393791,130.181061

Actor[exactname, "Cell of Lost Voices"]
${Actor[Query, Name == "Cell of Lost Voices"]}
427.90,108.74,188.74

(1652959780)[Thu May 19 07:29:40 2022] Sister Belladonna's Determined Strike hits Budali for 4,565,571,532 focus damage.



*/

variable string DoorName = ""
variable point3f North="420.66,109.24,152.15"
variable point3f CellofLostVoices="397.068054,109.393791,130.181061"
variable point3f PoolofLostVoices="387.109985,49.349998,105.699997"
variable point3f ReturnofLostVoices="387.122192,48.955917,128.850021"
variable point3f CellofIllIntent="442.726166,109.709114,132.173203"
variable point3f PoolofIllIntent="448.149994,49.349998,105.260002"
variable point3f ReturnofIllIntent="448.031647,48.955917,128.342697"

variable point3f SouthWest="456.27,108.82,233.31"
variable point3f CelloftheSpokenWord="463.217224,109.906990,258.667053"
variable point3f PooloftheSpokenWord="484.170013,49.349998,289.519989"
variable point3f ReturnoftheSpokenWord="484.093384,48.955917,266.435425"

variable point3f SouthEast="423.85,108.74,248.65"
variable point3f CelloftheWanderer="443.511078,108.739929,272.808563"
variable point3f PooloftheWanderer="427.040009,49.349998,289.279999"
variable point3f ReturnoftheWanderer="427.014282,48.955917,266.546906"

variable point3f PoolCampSpot=""
variable point3f ReturnCampSpot=""
variable point3f CampSpot="427.90,108.74,188.74"
variable bool CellCurse = FALSE
variable bool CellCurseCurable = FALSE


function main()
{
  echo start auntie
  oc !ci -campspot irw:${Me.Name} 2
  oc !ci -ccsw irw:${Me.Name} ${CampSpot.XYZ[" "]}
  wait 20

  while TRUE
  {
    if !${CellCurse}
      call CellCheck
    wait 20
  }
}

function CellCheck()
{
  variable index:point3f CellLocs
  variable int i

  if ${CellCurseCurable}
    return

  if ${OgreBotAPI.DetrimentalInfo[227,315]} || ${OgreBotAPI.DetrimentalInfo[197,315]}
    return

  CellCurse:Set[TRUE]

  if ${OgreBotAPI.DetrimentalInfo[3,127]}
  {
    DoorName:Set[IllIntent]
    CellLocs:Insert[${North}]
    CellLocs:Insert[${CellofIllIntent}]
    PoolCampSpot:Set[PoolofIllIntent]
    ReturnCampSpot:Set[ReturnofIllIntent]
  }
  elseif ${OgreBotAPI.DetrimentalInfo[442,495]}
  {
    DoorName:Set[SpokenWord]
    CellLocs:Insert[${SouthWest}]
    CellLocs:Insert[${CelloftheSpokenWord}]
    PoolCampSpot:Set[PooloftheSpokenWord]
    ReturnCampSpot:Set[ReturnoftheSpokenWord]
  }
  elseif ${OgreBotAPI.DetrimentalInfo[853,316]}
  {
    DoorName:Set[LostVoices]
    CellLocs:Insert[${North}]
    CellLocs:Insert[${CellofLostVoices}]
    PoolCampSpot:Set[PoolofLostVoices]
    ReturnCampSpot:Set[ReturnofLostVoices]
  }
  elseif ${OgreBotAPI.DetrimentalInfo[55,317]}
  {
    DoorName:Set[Wanderer]
    CellLocs:Insert[${SouthEast}]
    CellLocs:Insert[${CelloftheWanderer}]
    PoolCampSpot:Set[PooloftheWanderer]
    ReturnCampSpot:Set[ReturnoftheWanderer]
  }
  else
    CellCurse:Set[FALSE]

  if ${CellCurse}
  {
    oc ${Me.Name} is cursed
    for (i:Set[1]; ${i} <= ${CellLocs.Used}; i:Inc)
    {
      Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name},${CellLocs[${i}]}]
      while !${Ogre_CampSpot.AtCampSpot}
        waitframe
    }

    wait 10
    oc !c -special ${Me.Name}
    wait 20
    ; oc !c -campspot ${Me.Name}
    ; wait 10

    OgreBotAPI:Pause["${Me.Name}"]
    ; wait 20
    echo ${DoorName}
    ; run "my/actors"
    eq2ex waypoint ${PoolCampSpot}
    if ${b_OB_Paused}
      waitframe

    ; echo go to pool
    ; Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name},${PoolCampSpot}]
    ; while !${Ogre_CampSpot.AtCampSpot}
    ;   waitframe

    ; wait 10

    ; echo go to return
    ; Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name},${ReturnCampSpot}]
    ; while !${Ogre_CampSpot.AtCampSpot}
    ;   waitframe

    ; wait 10
    ; oc !c -special ${Me.Name}
    ; wait 20
    ; oc !c -campspot ${Me.Name}
    ; wait 10
    echo go to campspot
    Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name},${CampSpot}]
    while !${Ogre_CampSpot.AtCampSpot}
      waitframe

    CellCurseCurable:Set[TRUE]
    wait 100
    CellCurseCurable:Set[FALSE]
    CellCurse:Set[FALSE]
  }
}

atom atexit()
{
    echo "End Auntie"
}
