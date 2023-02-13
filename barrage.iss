function main()
{
	echo start
	while 1
	{
		if ${Me.InCombat} == True
		{
			wait 20
			if ${Me.Pet[0].Health} >= 80
			{
				wait 20
				if ${Me.Pet[0].Health} >= 80
				{
					wait 20
					Check:Set[${Me.Maintained["Barrage"]}]
					if ${Check.NotEqual["Barrage"]} && ${Me.Pet[0].Health} >= 80
					{
						echo Checks passed, Casting barrage!
						while ${Me.CastingSpell}==True
						{
							wait 20
						}
						OgreBotAtom a_CastFromUplink ${Me.Name} "Barrage" TRUE
						wait 30
					}
					else
					{
						continue
						echo Re-upping Barrage stacks
						wait 20
					}
				}
			}
		}
	}	
}