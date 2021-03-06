#loader crafttweaker reloadableevents
import crafttweaker.event.PlayerCraftedEvent;
import crafttweaker.events.IEventManager;
import crafttweaker.event.CommandEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.event.PlayerRespawnEvent;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import mods.zenutils.DelayManager;
import crafttweaker.command.ICommandManager;
import crafttweaker.text.ITextComponent;
import crafttweaker.event.PlayerChangedDimensionEvent;
import crafttweaker.world.IWorldInfo;
import crafttweaker.event.PlayerSleepInBedEvent;
import crafttweaker.recipes.ICraftingRecipe;
//Origins_Eternity
//2021.8.14
//events

events.onCommand(function(event as CommandEvent) {
   val command = event.command;
   if((command.name == "backup") || (command.name == "ct") || (command.name == "crafttweaker") || (command.name == "team")) {
       return;
   }
   else if (event.commandSender instanceof IPlayer) {
   val player as IPlayer = event.commandSender;
   player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.command.tip"));
   event.cancel(); 
   }
});

static DifficultyLocked as bool = false;

events.onPlayerRespawn(function(event as PlayerRespawnEvent) {
    val player as IPlayer = event.player;
    var ser = server.commandManager as ICommandManager;
    player.addPotionEffect(<potion:minecraft:invisibility>.makePotionEffect(12000, 5));
	player.addPotionEffect(<potion:minecraft:night_vision>.makePotionEffect(6000, 5));
	player.addPotionEffect(<potion:minecraft:hunger>.makePotionEffect(400, 1));
    if (DifficultyLocked == false) {
    DelayManager.addDelayWork(function() {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.difficulty.tip"));
    }, 1 * 20);
  }
});	

events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent) {
    var ser = server.commandManager as ICommandManager;
    if (isNull(event.player.data.wasGivenStarters)) {
    ser.executeCommand(server, "gamestage silentadd " + event.player.name + "greenhand");
    event.player.update({wasGivenStarters: true});
    var start = [
    <minecraft:stick>.withTag({ench: [{lvl: 5 as short, id: 19 as short}], RepairCost: 1}),
    <pyrotech:apple_baked>,
	<akashictome:tome>.withTag({"akashictome:data": {tconstruct: {id: "tconstruct:book", Count: 1 as byte, tag: {"akashictome:definedMod": "tconstruct"}, Damage: 0 as short}, botania: {id: "botania:lexicon", Count: 1 as byte, tag: {"akashictome:definedMod": "botania"}, Damage: 0 as short}, conarm: {id: "conarm:book", Count: 1 as byte, tag: {"akashictome:definedMod": "conarm"}, Damage: 0 as short}, ftbquests: {id: "ftbquests:book", Count: 1 as byte, tag: {"akashictome:definedMod": "ftbquests"}, Damage: 0 as short}, immersiveengineering: {id: "immersiveengineering:tool", Count: 1 as byte, tag: {"akashictome:definedMod": "immersiveengineering"}, Damage: 3 as short}, twilightforest: {id: "patchouli:guide_book", Count: 1 as byte, tag: {"akashictome:definedMod": "twilightforest", "patchouli:book": "twilightforest:guide"}, Damage: 0 as short}, valkyrielib: {id: "valkyrielib:guide", Count: 1 as byte, tag: {"akashictome:definedMod": "valkyrielib"}, Damage: 0 as short}, pyrotech: {id: "pyrotech:book", Count: 1 as byte, tag: {"akashictome:definedMod": "pyrotech"}, Damage: 0 as short}}})
] as IItemStack[];
for i in start
	{
    event.player.give(i);
	}
    DelayManager.addDelayWork(function() {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.login.begin"));
    }, 1 * 20);
	DelayManager.addDelayWork(function() {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.login.modloaded"));
    }, 3 * 20);
    if (DifficultyLocked == false) {
    DelayManager.addDelayWork(function() {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.difficulty.tip"));
    }, 5 * 20);
	}
  }
});

<minecraft:stick>.withTag({ench: [{lvl: 5 as short, id: 19 as short}], RepairCost: 1}).addTooltip(game.localize("crafttweaker.stick.tooltip"));

events.onPlayerChangedDimension(function(event as PlayerChangedDimensionEvent) {
    var ser = server.commandManager as ICommandManager;
    event.player.addPotionEffect(<potion:minecraft:hunger>.makePotionEffect(1000, 3)); 
    if (DifficultyLocked == false) {
    DelayManager.addDelayWork(function() {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.login.difficulty"));
        }, 5 * 20);
    DelayManager.addDelayWork(function() {
    var info = event.fromWorld.getWorldInfo();
    var Locked = info.isDifficultyLocked();
    var difficulty = info.getDifficulty();
    var info1 = event.toWorld.getWorldInfo();
    var Locked1 = info1.isDifficultyLocked();
    var difficulty1 = info1.getDifficulty();
    if ((Locked != true) || (Locked1 != true)) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.difficulty.choose"));
    }  
    if ((difficulty == "PEACEFUL" && Locked != true) || (difficulty1 == "PEACEFUL" && Locked1 != true)) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.difficulty.peaceful"));
    }
        }, 15 * 20);
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.10"));
        }, 16 * 20);
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.9"));
        }, 17 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.8"));
        }, 18 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.7"));
        }, 19 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.6"));
        }, 20 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.5"));
        }, 21 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.4"));
        }, 22 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.3"));
        }, 23 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.2"));
        }, 24 * 20); 
    DelayManager.addDelayWork(function() { 
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.1"));
        }, 25 * 20); 
    DelayManager.addDelayWork(function() {
    var info2 = event.fromWorld.getWorldInfo();
    var Locked2 = info2.isDifficultyLocked();
    var difficulty2 = info2.getDifficulty();
    var info3 = event.toWorld.getWorldInfo();
    var Locked3 = info3.isDifficultyLocked();
    var difficulty3 = info3.getDifficulty();
    if ((Locked2 == true) && (difficulty2 != "PEACEFUL") && (Locked3 == true) && (difficulty3 != "PEACEFUL")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.difficulty.locked"));
        DifficultyLocked = true;
    } else {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.difficulty.notchoose")); 
        recipes.removeAll();
        ser.executeCommand(server, "gamemode spectator " + event.player.name);
    }  
        }, 26 * 20);
  } else {
        DifficultyLocked = true;
  }
});

//2022.3.27
events.onPlayerCrafted(function(event as PlayerCraftedEvent) {
    var ser = server.commandManager as ICommandManager;
	if ((isNull(event.player.data.wasGivenTip1)) && (event.output.definition.id == "pyrotech:compacting_bin")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip1"));
        event.player.update({wasGivenTip1: true});
    }
    if ((isNull(event.player.data.wasGivenTip2)) && (event.output.definition.id == "pyrotech:bloomery")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip2"));
        event.player.update({wasGivenTip2: true});
    }
    if ((isNull(event.player.data.wasGivenTip3)) && (event.output.definition.id == "artisanworktables:workstation:14")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip3"));
        event.player.update({wasGivenTip3: true});
    }
    if ((isNull(event.player.data.wasGivenTip4)) && (event.output.definition.id == "pyrotech:brick_oven")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip4"));
        event.player.update({wasGivenTip4: true});
    }
    if ((isNull(event.player.data.wasGivenTip5)) && (event.output.definition.id == "contenttweaker:obsidian_nomana")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip5"));
        event.player.update({wasGivenTip5: true});
    }
    if ((isNull(event.player.data.wasGivenTip6)) && (event.output.definition.id == "botania:pool:2")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip6"));
        event.player.update({wasGivenTip6: true});
    }
    if ((isNull(event.player.data.wasGivenTip7)) && (event.output.definition.id == "minecraft:diamond")) {
        event.player.sendRichTextMessage(ITextComponent.fromTranslation("crafttweaker.message.craft.tip7"));
        event.player.update({wasGivenTip7: true});
    }
    if ((isNull(event.player.data.wasGivenTip8)) && (event.output.definition.id == "pyrotech:furnace_core")) {
        ser.executeCommand(server, "gamestage silentremove " + event.player.name + "greenhand");
        event.player.update({wasGivenTip8: true});
    }
});

events.onPlayerSleepInBed(function(event as PlayerSleepInBedEvent) {
    val player as IPlayer = event.player;
	player.addPotionEffect(<potion:minecraft:hunger>.makePotionEffect(200, 2));
});