function main(bool _Unequip=TRUE)
{
    variable bool bSpew=FALSE
    variable Object_Tishan Obj_Tishan

    if ${bSpew}
        Obj_Tishan:Spew
    else
        call Obj_Tishan.Handle ${_Unequip}
}

objectdef Object_Tishan
{
    variable string MerchantName="Tishan's Lockbox"
    variable index:string NewItems
    function Handle(bool _Unequip=TRUE)
    {
        if ${_Unequip}
            call This.Unequip

        call BuyItems
        call EquipItems
    }
    method Spew()
    {
        variable int iCounter
        for ( iCounter:Set[1] ; ${iCounter} <= ${MerchantWindow.NumMerchantItemsForSale} ; iCounter:Inc )
        {
            echo ${MerchantWindow.MerchantInventory[${iCounter}]}
        }
    }
    function BuyItems()
    {
        variable int64 ActorID
        ActorID:Set[${Actor[Query, Name = "${This.MerchantName}" && Interactable && Distance < 10].ID}]
        if ${ActorID} == 0
        {
            echo ${Time}: Unable to find ${This.MerchantName}
            return
        }
        Actor[id,${ActorID}]:DoubleClick
        wait 10

        variable int iCounter
        for ( iCounter:Set[1] ; ${iCounter} <= ${NewItems.Used} ; iCounter:Inc )
        {
            if ${MerchantWindow.MerchantInventory["${This.NewItems[${iCounter}]}"](exists)}
            {
                MerchantWindow.MerchantInventory["${This.NewItems[${iCounter}]}"]:Buy[1]
                wait 10
            }
            else
                echo ${This.NewItems[${iCounter}]} not available on merchant
        }
        MerchantWindow:Close
        wait 10

    }
    function EquipItems()
    {
        variable int iCounter
        This.NewItems:Insert["Archivist's Rough Crossbow Bolt"]

        for ( iCounter:Set[1] ; ${iCounter} <= ${NewItems.Used} ; iCounter:Inc )
        {
            if ${Me.Inventory["${This.NewItems[${iCounter}]}"].ID(exists)}
            {
                Me.Inventory["${This.NewItems[${iCounter}]}"]:Equip
                wait 10
            }
        }
    }
    function Unequip()
    {
        variable int iMaxGear=22
        variable int iCounter

        for ( iCounter:Set[1] ; ${iCounter} <= ${iMaxGear} ; iCounter:Inc )
        {
            if ${Me.Equipment[${iCounter}].ID(exists)}
            {
                ; echo [${iCounter}] ${Me.Equipment[${iCounter}].ID(exists)} * ${Me.Equipment[${iCounter}].Name}
                Me.Equipment[${iCounter}]:UnEquip
                wait 2
            }
        }
    }
    method Initialize()
    {
        This.NewItems:Insert["Ammo Pouch"]
        ; This.NewItems:Insert["Displaced Harbinger"]

        This.NewItems:Insert["Hopewell Belt of Stratagem"]
        This.NewItems:Insert["Hopewell Bracelet of Foresight"]
        This.NewItems:Insert["Hopewell Bracelet of Insight"]
        This.NewItems:Insert["Hopewell Charm of Insight"]
        This.NewItems:Insert["Hopewell Charm of Stratagem"]
        This.NewItems:Insert["Hopewell Cloak of Stratagem"]
        This.NewItems:Insert["Hopewell Earring of Foresight"]
        This.NewItems:Insert["Hopewell Earring of Insight"]
        This.NewItems:Insert["Hopewell Necklace of Stratagem"]
        This.NewItems:Insert["Hopewell Ring of Foresight"]
        This.NewItems:Insert["Hopewell Ring of Insight"]

        This.NewItems:Insert["Hopewell Staff of Stratagem"]
        This.NewItems:Insert["Hopewell Mace of Foresight"]
        This.NewItems:Insert["Hopewell Mace of Insight"]
        if ${Me.Archetype.Equal["mage"]}
            This.NewItems:Insert["Hopewell Wand of Foresight"]
        elseif ${Me.Archetype.Equal["healer"]}
            This.NewItems:Insert["Hopewell Wand of Foresight"]
        else
            This.NewItems:Insert["Hopewell Bow of Stratagem"]
        
        This.NewItems:Insert["Hopewell Cloth Boots of Insight"]
        This.NewItems:Insert["Hopewell Cloth Bracer of Stratagem"]
        This.NewItems:Insert["Hopewell Cloth Coif of Insight"]
        This.NewItems:Insert["Hopewell Cloth Gauntlets of Foresight"]
        This.NewItems:Insert["Hopewell Cloth Greaves of Foresight"]
        This.NewItems:Insert["Hopewell Cloth Shirt of Stratagem"]
        This.NewItems:Insert["Hopewell Cloth Pauldrons of Insight"]

        This.NewItems:Insert["Hopewell Chain Boots of Insight"]
        This.NewItems:Insert["Hopewell Chain Bracer of Stratagem"]
        This.NewItems:Insert["Hopewell Chain Coif of Insight"]
        This.NewItems:Insert["Hopewell Chain Gauntlets of Foresight"]
        This.NewItems:Insert["Hopewell Chain Greaves of Foresight"]
        This.NewItems:Insert["Hopewell Chain Shirt of Stratagem"]
        This.NewItems:Insert["Hopewell Chain Pauldrons of Insight"]

        This.NewItems:Insert["Hopewell Plate Boots of Insight"]
        This.NewItems:Insert["Hopewell Plate Bracer of Stratagem"]
        This.NewItems:Insert["Hopewell Plate Coif of Insight"]
        This.NewItems:Insert["Hopewell Plate Gauntlets of Foresight"]
        This.NewItems:Insert["Hopewell Plate Greaves of Foresight"]
        This.NewItems:Insert["Hopewell Plate Shirt of Stratagem"]
        This.NewItems:Insert["Hopewell Plate Pauldrons of Insight"]
        
        This.NewItems:Insert["Hopewell Leather Boots of Insight"]
        This.NewItems:Insert["Hopewell Leather Bracer of Stratagem"]
        This.NewItems:Insert["Hopewell Leather Coif of Insight"]
        This.NewItems:Insert["Hopewell Leather Gauntlets of Foresight"]
        This.NewItems:Insert["Hopewell Leather Greaves of Foresight"]
        This.NewItems:Insert["Hopewell Leather Shirt of Stratagem"]
        This.NewItems:Insert["Hopewell Leather Pauldrons of Insight"] 
    }
}