#priority 0
import crafttweaker.item.IItemStack;
import mods.pyrotech.Stages;
import mods.pyrotech.Worktable;
import mods.pyrotech.CompactingBin;
import mods.pyrotech.BrickKiln;
import mods.pyrotech.BrickOven;
import mods.pyrotech.MechanicalCompactor;
import mods.pyrotech.StoneSawmill;
import mods.pyrotech.Campfire;
import mods.pyrotech.StoneKiln;
import mods.pyrotech.PitKiln;
import mods.pyrotech.BrickCrucible;
import mods.pyrotech.BrickSawmill;
import mods.pyrotech.IroncladAnvil;
import mods.pyrotech.GraniteAnvil;
import mods.pyrotech.SoakingPot;
import mods.zenutils.StringList;
import mods.pyrotech.StoneCrucible;
import crafttweaker.text.ITextComponent;
import crafttweaker.recipes.ICraftingRecipe;
import mods.pyrotech.StoneOven;
//Lacz
//2020.10.16
//pyrotech
import crafttweaker.item.IIngredient;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.oredict.IOreDictEntry;
import mods.pyrotech.CrudeDryingRack;
import mods.pyrotech.DryingRack;
import mods.pyrotech.Burn;

function pyrKilns(name as string, output as IItemStack, input as IIngredient, failed as IItemStack, time as int){
    PitKiln.removeRecipes(output);
    StoneKiln.removeRecipes(output);
    BrickKiln.removeRecipes(output);
    PitKiln.addRecipe(name, output, input, time, 0.2, [failed]);
    StoneKiln.addRecipe(name, output, input, time - 30*20, 0.1, [failed*2, failed*3]);
    BrickKiln.addRecipe(name, output, input, time - 90*20, 0.05, [failed*5]);
}
pyrKilns("pyrotech_bucket_clay", <pyrotech:bucket_clay>, <pyrotech:bucket_clay_unfired>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_clay_shears", <pyrotech:clay_shears>, <pyrotech:unfired_clay_shears>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mcbrick", <minecraft:brick>, <pyrotech:material:24>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_charcoal_piece", <pyrotech:material:15>, <pyrotech:rock:7>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mcstone_slab", <minecraft:stone_slab>, <minecraft:stone_slab:3>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mcstone", <minecraft:stone>, <minecraft:cobblestone>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mcandesite", <minecraft:stone:5>, <pyrotech:cobblestone>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mcgranite", <minecraft:stone:1>, <pyrotech:cobblestone:2>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mcdiarite", <minecraft:stone:3>, <pyrotech:cobblestone:1>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_limestone", <pyrotech:limestone>, <pyrotech:cobblestone:3>, <pyrotech:material>, 120*20);
pyrKilns("pyrotech_mchardened_clay", <minecraft:hardened_clay>, <minecraft:clay>, <pyrotech:material>, 120*20);

function pyrRack(name as string, output as IItemStack, input as IIngredient, time as int){
    CrudeDryingRack.addRecipe(name, output, input, time);
    DryingRack.addRecipe(name, output, input, time - 30*20);
}
CrudeDryingRack.removeAllRecipes();
DryingRack.removeAllRecipes();
pyrRack("pyrotech_mcpaper", <minecraft:paper>, <pyrotech:material:25>, 120*20);
pyrRack("pyrotech_mcsponge", <minecraft:sponge>, <minecraft:sponge:1>, 120*20);
pyrRack("pyrotech_dry_fiber1", <pyrotech:material:13>, <ore:treeSapling>, 120*20);
pyrRack("pyrotech_dry_fiber2", <pyrotech:material:13>, <pyrotech:material:12>, 120*20);
pyrRack("pyrotech_straw", <pyrotech:material:2>, <minecraft:wheat>, 120*20);

recipes.remove(<pyrotech:worktable_stone>);
Worktable.buildShaped(<pyrotech:worktable_stone>, [
[<pyrotech:material:16>, <pyrotech:masonry_brick_block>, <pyrotech:material:16>],
[<minecraft:cobblestone>, <pyrotech:worktable>, <minecraft:cobblestone>],
[<pyrotech:material:16>, <pyrotech:masonry_brick_block>, <pyrotech:material:16>]
])
.setName("custom_recipe_stoneworktable")
.setTool(<pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 3)
.register();

val ietool as IItemStack = <immersiveengineering:tool>.transformDamage(1);
function pyrWorktableCreate(modid as string, name as string, output as IItemStack, slot1 as IItemStack, slot2 as IItemStack, slot3 as IItemStack, slot4 as IItemStack, slot5 as IItemStack, slot6 as IItemStack, slot7 as IItemStack, slot8 as IItemStack, slot9 as IItemStack, damage as int){
    Worktable.buildShaped(output, [[slot1, slot2, slot3], [slot4, slot5, slot6], [slot7, slot8, slot9]])
        .setName(modid ~ name)
        .setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, damage)
        .register();
}
pyrWorktableCreate("IE", "_tieban", <immersiveengineering:metal:39>, null, <minecraft:iron_ingot>, null, null, ietool, null, null, null, null, 2);
pyrWorktableCreate("tconstruct", "_jianzhuding", <tconstruct:punji>*5, <minecraft:reeds>, null, <minecraft:reeds>, null, <minecraft:reeds>, null, <minecraft:reeds>, null, <minecraft:reeds>, 5);
pyrWorktableCreate("artisans", "_hammerwood", <artisanworktables:artisans_hammer_wood>, null, <minecraft:planks:*>, <minecraft:string>, null, <minecraft:stick>, <minecraft:planks:*>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_hammerstone", <artisanworktables:artisans_hammer_stone>, null, <minecraft:stone>, <minecraft:string>, null, <minecraft:stick>, <minecraft:stone>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_hammerbone", <artisanworktables:artisans_hammer_bone>, null, <minecraft:bone>, <minecraft:string>, null, <minecraft:stick>, <minecraft:bone>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_hammerflint", <artisanworktables:artisans_hammer_flint>, null, <minecraft:flint>, <minecraft:string>, null, <minecraft:stick>, <minecraft:flint>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_carverwood", <artisanworktables:artisans_carver_wood>, null, null, <minecraft:planks:*>, <minecraft:string>, <minecraft:stick>, <minecraft:string>, <minecraft:planks:*>, null, null, 3);
pyrWorktableCreate("artisans", "_carverstone", <artisanworktables:artisans_carver_stone>, null, null, <minecraft:stone>, <minecraft:string>, <minecraft:stick>, <minecraft:string>, <minecraft:stone>, null, null, 3);
pyrWorktableCreate("artisans", "_carverbone", <artisanworktables:artisans_carver_bone>, null, null, <minecraft:bone>, <minecraft:string>, <minecraft:stick>, <minecraft:string>, <minecraft:bone>, null, null, 3);
pyrWorktableCreate("artisans", "_carverflint", <artisanworktables:artisans_carver_flint>, null, null, <minecraft:flint>, <minecraft:string>, <minecraft:stick>, <minecraft:string>, <minecraft:flint>, null, null, 3);
pyrWorktableCreate("artisans", "_handsawwood", <artisanworktables:artisans_handsaw_wood>, null, <minecraft:planks:*>, <minecraft:string>, <minecraft:planks:*>, <minecraft:stick>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_handsawstone", <artisanworktables:artisans_handsaw_stone>, null, <minecraft:stone>, <minecraft:string>, <minecraft:stone>, <minecraft:stick>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_handsawbone", <artisanworktables:artisans_handsaw_bone>, null, <minecraft:bone>, <minecraft:string>, <minecraft:bone>, <minecraft:stick>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_handsawflint", <artisanworktables:artisans_handsaw_flint>, null, <minecraft:flint>, <minecraft:string>, <minecraft:flint>, <minecraft:stick>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_tsquare_wood", <artisanworktables:artisans_tsquare_wood>, <minecraft:stick>, <minecraft:stick>, <minecraft:stick>, null, <minecraft:planks:*>, null, null, <minecraft:planks:*>, null, 3);
pyrWorktableCreate("artisans", "_tsquare_stone", <artisanworktables:artisans_tsquare_stone>, <minecraft:stick>, <minecraft:stick>, <minecraft:stick>, null, <minecraft:stone>, null, null, <minecraft:stone>, null, 3);
pyrWorktableCreate("artisans", "_tsquare_bone", <artisanworktables:artisans_tsquare_bone>, <minecraft:stick>, <minecraft:stick>, <minecraft:stick>, null, <minecraft:bone>, null, null, <minecraft:bone>, null, 3);
pyrWorktableCreate("artisans", "_tsquare_flint", <artisanworktables:artisans_tsquare_flint>, <minecraft:stick>, <minecraft:stick>, <minecraft:stick>, null, <minecraft:flint>, null, null, <minecraft:flint>, null, 3);
pyrWorktableCreate("artisans", "_spanner_wood", <artisanworktables:artisans_spanner_wood>, null, <minecraft:planks:*>, null, null, <minecraft:stick>, <minecraft:planks:*>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_spanner_stone", <artisanworktables:artisans_spanner_stone>, null, <minecraft:stone>, null, null, <minecraft:stick>, <minecraft:stone>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_spanner_bone", <artisanworktables:artisans_spanner_bone>, null, <minecraft:bone>, null, null, <minecraft:stick>, <minecraft:bone>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_spanner_flint", <artisanworktables:artisans_spanner_flint>, null, <minecraft:flint>, null, null, <minecraft:stick>, <minecraft:flint>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_driver_wood", <artisanworktables:artisans_driver_wood>, null, null, <minecraft:planks:*>, null, <minecraft:planks:*>, null, <minecraft:stick>, <minecraft:string>, null, 3);
pyrWorktableCreate("artisans", "_driver_stone", <artisanworktables:artisans_driver_stone>, null, null, <minecraft:stone>, null, <minecraft:stone>, null, <minecraft:stick>, <minecraft:string>, null, 3);
pyrWorktableCreate("artisans", "_driver_bone", <artisanworktables:artisans_driver_bone>, null, null, <minecraft:bone>, null, <minecraft:bone>, null, <minecraft:stick>, <minecraft:string>, null, 3);
pyrWorktableCreate("artisans", "_driver_flint", <artisanworktables:artisans_driver_flint>, null, null, <minecraft:flint>, null, <minecraft:flint>, null, <minecraft:stick>, <minecraft:string>, null, 3);
pyrWorktableCreate("artisans", "_trowel_wood", <artisanworktables:artisans_trowel_wood>, null, null, <minecraft:planks:*>, null, <minecraft:stick>, <minecraft:planks:*>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_trowel_stone", <artisanworktables:artisans_trowel_stone>, null, null, <minecraft:stone>, null, <minecraft:stick>, <minecraft:stone>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_trowel_bone", <artisanworktables:artisans_trowel_bone>, null, null, <minecraft:bone>, null, <minecraft:stick>, <minecraft:bone>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_trowel_flint", <artisanworktables:artisans_trowel_flint>, null, null, <minecraft:flint>, null, <minecraft:stick>, <minecraft:flint>, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_chisel_wood", <artisanworktables:artisans_chisel_wood>, null, null, <minecraft:planks:*>, null, <minecraft:planks:*>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_chisel_stone", <artisanworktables:artisans_chisel_stone>, null, null, <minecraft:stone>, null, <minecraft:stone>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_chisel_bone", <artisanworktables:artisans_chisel_bone>, null, null, <minecraft:bone>, null, <minecraft:bone>, null, <minecraft:stick>, null, null, 3);
pyrWorktableCreate("artisans", "_chisel_flint", <artisanworktables:artisans_chisel_flint>, null, null, <minecraft:flint>, null, <minecraft:flint>, null, <minecraft:stick>, null, null, 3);


//Origins_Eternity
//2021.1.22
var items = [
<pyrotech:wither_forge>,
<pyrotech:bag_durable>,
<pyrotech:bag_simple>,
<pyrotech:drying_rack:1>,
<pyrotech:flint_shovel>,
<pyrotech:flint_sword>,
<pyrotech:flint_hoe>,
<pyrotech:flint_pickaxe>,
<pyrotech:flint_axe>,
<pyrotech:straw_bed>,
<pyrotech:furnace_core>

] as IItemStack[];

for item in items {
    recipes.remove(item);
    }

Worktable.buildShaped(<pyrotech:flint_axe>, [
[<pyrotech:material:10>, <pyrotech:material:10>, null],
[<pyrotech:material:10>, <pyrotech:material:27>, null],
[null, <pyrotech:material:27>, null]
])
.setName("flintaxe")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

Worktable.buildShaped(<pyrotech:flint_pickaxe>, [
[<pyrotech:material:10>, <pyrotech:material:10>, <pyrotech:material:10>],
[null, <pyrotech:material:27>, null],
[null, <pyrotech:material:27>, null]
])
.setName("flintpickaxe")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

Worktable.buildShaped(<pyrotech:flint_hoe>, [
[<pyrotech:material:10>, <pyrotech:material:10>, null],
[null, <pyrotech:material:27>, null],
[null, <pyrotech:material:27>, null]
])
.setName("flinthoe")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

Worktable.buildShaped(<pyrotech:flint_sword>, [
[null, <pyrotech:material:10>, null],
[null, <pyrotech:material:10>, null],
[null, <pyrotech:material:27>, null]
])
.setName("flintsword")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

Worktable.buildShaped(<pyrotech:flint_shovel>, [
[null, <pyrotech:material:10>, null],
[null, <pyrotech:material:27>, null],
[null, <pyrotech:material:27>, null]
])
.setName("flintshovel")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

recipes.remove(<pyrotech:flint_hammer>);
Worktable.buildShaped(<pyrotech:flint_hammer>, [
[null, <pyrotech:material:10>, <ore:twine>],
[null, <pyrotech:material:27>, <pyrotech:material:10>],
[<pyrotech:material:27>, null, null]
])
.setName("flinthammer")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

var tool = [

<pyrotech:obsidian_hammer>,
<pyrotech:obsidian_axe>,
<pyrotech:obsidian_pickaxe>,
<pyrotech:obsidian_shovel>,
<pyrotech:obsidian_sword>,
<pyrotech:obsidian_hoe>

] as IItemStack[];
for items in tool
    {
recipes.remove(items);
    }

var compacting_bin_recipes = [

<pyrotech:generated_pile_slag_aluminum>,
<pyrotech:generated_pile_slag_ardite>,
<pyrotech:generated_pile_slag_uranium>,
<pyrotech:generated_pile_slag_cobalt>,
<pyrotech:generated_pile_slag_silver>,
<pyrotech:generated_pile_slag_nickel>,
<pyrotech:generated_pile_slag_osmium>,
<pyrotech:generated_pile_slag_lead>,
<pyrotech:generated_pile_slag_tungsten>,
<pyrotech:generated_pile_slag_dilithium>,
<pyrotech:generated_pile_slag_abyssum>,
<pyrotech:generated_pile_slag_eezo>,
<pyrotech:generated_pile_slag_osram>,
<pyrotech:generated_pile_slag_palladium>,
<pyrotech:generated_pile_slag_prometheum>,
<pyrotech:generated_pile_slag_valyrium>,
<pyrotech:generated_pile_slag_uru>,
<pyrotech:generated_pile_slag_tiberium>,
<pyrotech:generated_pile_slag_vibranium>,
<pyrotech:generated_pile_slag_magnesium>,
<pyrotech:generated_pile_slag_silicon>,
<minecraft:quartz_block>

] as IItemStack[];

for items in compacting_bin_recipes 
    {
CompactingBin.removeRecipes(items);
    }
	
CompactingBin.addRecipe("flint_from_gravel", <minecraft:flint>, <ore:gravel>, 4);


BrickKiln.addRecipe("netherbrick_from_netherrack", <minecraft:netherbrick>, <minecraft:netherrack>, 6000, 0.8, [<pyrotech:rock_netherrack>*4]);
BrickOven.addRecipe("blaze_powder_from_blaze_rod", <minecraft:blaze_powder>, <minecraft:blaze_rod>);

//2021.8.10

recipes.remove(<pyrotech:cog_diamond>);
recipes.addShaped(<pyrotech:cog_diamond>,
[[<pyrotech:material:18>, <pyrotech:material:18>, <pyrotech:material:18>],
[<pyrotech:material:18>, <minecraft:diamond_block>, <pyrotech:material:18>],
[<pyrotech:material:18>, <pyrotech:material:18>, <pyrotech:material:18>]]);

MechanicalCompactor.addRecipe("iron_block_from_ingot", <minecraft:iron_block>, <ore:ingotIron>, 9);
MechanicalCompactor.addRecipe("gold_block_from_ingot", <minecraft:gold_block>, <ore:ingotGold>, 9);
MechanicalCompactor.addRecipe("diamond_block_from_diamond", <minecraft:diamond_block>, <ore:gemDiamond>, 9);
MechanicalCompactor.addRecipe("emerald_block_from_emerald", <minecraft:emerald_block>, <ore:gemEmerald>, 9);
MechanicalCompactor.addRecipe("slime_block_from_slimeball", <minecraft:slime>, <ore:slimeball>, 9);
MechanicalCompactor.addRecipe("slakedlime_block_from_slakedlime", <contenttweaker:slakedlime_block>, <pyrotech:material:8>, 9);
MechanicalCompactor.addRecipe("slakedlime_block_from_cement_powder", <tconstruct:soil>, <contenttweaker:cement_powder>, 9);
MechanicalCompactor.addRecipe("silicon_from_nugget", <galacticraftcore:basic_item:2>, <contenttweaker:silicon_nugget>, 9);
MechanicalCompactor.addRecipe("obsidiorite_block_from_ingot", <taiga:obsidiorite_block>, <taiga:obsidiorite_ingot>, 9);
MechanicalCompactor.addRecipe("meteorite_block_from_ingot", <taiga:meteorite_block>, <taiga:meteorite_ingot>, 9);
MechanicalCompactor.addRecipe("steel_block_from_ingot", <immersiveengineering:storage:8>, <ore:ingotSteel>, 9);
MechanicalCompactor.addRecipe("quartz_block_from_ingot", <minecraft:quartz_block>, <ore:gemQuartz>, 9);
MechanicalCompactor.addRecipe("copper_block_from_ingot", <mekanism:basicblock:12>, <ore:ingotCopper>, 9);
MechanicalCompactor.addRecipe("alumite_block_from_ingot", <plustic:alumiteblock>, <ore:ingotAlumite>,9);
MechanicalCompactor.addRecipe("invar_block_from_ingot", <plustic:invarblock>, <ore:ingotInvar>,9);
MechanicalCompactor.addRecipe("cobalt_block_from_ingot", <tconstruct:metal>, <ore:ingotCobalt>,9);
MechanicalCompactor.addRecipe("ardite_block_from_ingot", <tconstruct:metal:1>, <ore:blockArdite>,9);
MechanicalCompactor.addRecipe("manyullyn_block_from_ingot", <tconstruct:metal:2>, <ore:blockManyullyn>,9);
MechanicalCompactor.addRecipe("knightslime_block_from_ingot", <tconstruct:metal:3>, <ore:blockKnightslime>,9);
MechanicalCompactor.addRecipe("alubrass_block_from_ingot", <tconstruct:metal:5>, <ore:blockAlubrass>,9);
MechanicalCompactor.addRecipe("knightmetal_block_from_ingot", <twilightforest:knightmetal_block>, <ore:ingotKnightmetal>,9);
MechanicalCompactor.addRecipe("fiery_block_from_ingot", <twilightforest:block_storage:1>, <ore:blockFiery>,9);
MechanicalCompactor.addRecipe("ironwood_block_from_ingot", <twilightforest:block_storage>, <ore:ingotIronwood>,9);
MechanicalCompactor.addRecipe("quartz_enriched_iron_block_from_ingot", <refinedstorage:quartz_enriched_iron_block>, <refinedstorage:quartz_enriched_iron>,9);
MechanicalCompactor.addRecipe("draconium_block_from_ingot", <draconicevolution:draconium_block>, <ore:blockDraconium>,9);
MechanicalCompactor.addRecipe("draconic_block_from_ingot", <draconicevolution:draconic_block>, <ore:ingotDraconiumAwakened>,9);
MechanicalCompactor.addRecipe("aluminum_block_from_ingot", <galacticraftcore:basic_block_core:11>, <ore:ingotAluminum>,9);
MechanicalCompactor.addRecipe("meteoricIron_block_from_ingot", <galacticraftcore:basic_block_core:12>, <ore:ingotMeteoricIron>,9);
MechanicalCompactor.addRecipe("silicon_block_from_ingot", <galacticraftcore:basic_block_core:13>, <ore:itemSilicon>,9);
MechanicalCompactor.addRecipe("titanium_block_from_ingot", <galacticraftplanets:asteroids_block:7>, <ore:ingotTitanium>,9);
MechanicalCompactor.addRecipe("desh_block_from_ingot", <galacticraftplanets:mars:8>, <ore:blockDesh>,9);
MechanicalCompactor.addRecipe("Electrum_block_from_ingot", <immersiveengineering:storage:7>, <ore:ingotElectrum>,9);
MechanicalCompactor.addRecipe("constantan_block_from_ingot", <immersiveengineering:storage:6>, <ore:blockConstantan>,9);
MechanicalCompactor.addRecipe("nickel_block_from_ingot", <immersiveengineering:storage:4>, <ore:blockNickel>,9);
MechanicalCompactor.addRecipe("silver_block_from_ingot", <immersiveengineering:storage:3>, <ore:blockSilver>,9);
MechanicalCompactor.addRecipe("uranium_block_from_ingot", <immersiveengineering:storage:5>, <ore:blockUranium>,9);
MechanicalCompactor.addRecipe("osmium_block_from_ingot", <mekanism:basicblock>, <ore:ingotOsmium>,9);
MechanicalCompactor.addRecipe("bronze_block_from_ingot", <mekanism:basicblock:1>, <ore:ingotBronze>,9);
MechanicalCompactor.addRecipe("refinedobsidian_block_from_ingot", <mekanism:basicblock:2>, <ore:ingotRefinedObsidian>,9);
MechanicalCompactor.addRecipe("coal_block_from_ingot", <mekanism:basicblock:3>, <ore:charcoal>,9);
MechanicalCompactor.addRecipe("refinedglowstone_block_from_ingot", <mekanism:basicblock:4>, <ore:ingotRefinedGlowstone>,9);
MechanicalCompactor.addRecipe("salt_block_from_ingot", <mekanism:saltblock>, <ore:dustSalt>,9);
MechanicalCompactor.addRecipe("mobius_fuel_block_from_ingot", <projecte:fuel_block:1>, <projecte:item.pe_fuel:1>,9);
MechanicalCompactor.addRecipe("aeternalis_fuel_block_from_ingot", <projecte:fuel_block:2>, <projecte:item.pe_fuel:2>,9);
MechanicalCompactor.addRecipe("achemical_coal_fuel_block_from_ingot", <projecte:fuel_block>, <projecte:item.pe_fuel>,9);
MechanicalCompactor.addRecipe("steeleaf_block_from_ingot", <twilightforest:block_storage:2>, <ore:ingotSteeleaf>,9);
MechanicalCompactor.addRecipe("carminite_block_from_ingot", <twilightforest:block_storage:4>, <ore:carminite>,9);
MechanicalCompactor.addRecipe("lead_block_from_ingot", <galacticraftplanets:venus:12>, <ore:ingotLead>,9);
MechanicalCompactor.addRecipe("furarctic_block_from_ingot", <twilightforest:block_storage:3>, <ore:furArctic>,9);

var worktable_recipes = [

"minecraft:wooden_sword", 
"minecraft:bow", 
"minecraft:iron_ingot_from_nuggets", 
"minecraft:gold_ingot_from_nuggets", 
"immersiveengineering:metal_storge/copper_ingot", 
"mekanism:ingot_5_alt", 
"mekanism:ingot_6_alt", 
"mekanism:basicblock_12", 
"minecraft:stonebrick", 
"minecraft:polished_granite", 
"tconstruct:tools/pattern", 
"tconstruct:tools/table/stencil_table", 
"tconstruct:tools/table/part_builder", 
"minecraft:piston"

] as string[];
for items in worktable_recipes
    {
Worktable.whitelistVanillaRecipes([items]);
    }

StoneSawmill.addRecipe("flour_from_cropWheat", <contenttweaker:flour>, <ore:cropWheat>, 200, <pyrotech:sawmill_blade_iron:*> | <pyrotech:sawmill_blade_stone:*> | <pyrotech:sawmill_blade_bone:*> | <pyrotech:sawmill_blade_flint:*> | <pyrotech:sawmill_blade_diamond:*> | <pyrotech:sawmill_blade_gold:*> | <pyrotech:sawmill_blade_obsidian:*>, 0);
BrickSawmill.addRecipe("flour_from_cropWheat2", <contenttweaker:flour>, <ore:cropWheat>, 200, <pyrotech:sawmill_blade_iron:*> | <pyrotech:sawmill_blade_stone:*> | <pyrotech:sawmill_blade_bone:*> | <pyrotech:sawmill_blade_flint:*> | <pyrotech:sawmill_blade_diamond:*> | <pyrotech:sawmill_blade_gold:*> | <pyrotech:sawmill_blade_obsidian:*>, 0);
BrickSawmill.addRecipe("cement_powder_from_soil", <contenttweaker:cement_powder>, <tconstruct:soil>, 400, <pyrotech:sawmill_blade_iron:*> | <pyrotech:sawmill_blade_stone:*> | <pyrotech:sawmill_blade_bone:*> | <pyrotech:sawmill_blade_flint:*> | <pyrotech:sawmill_blade_diamond:*> | <pyrotech:sawmill_blade_gold:*> | <pyrotech:sawmill_blade_obsidian:*>, 0);

Campfire.removeRecipes(<minecraft:bread>);
Campfire.removeRecipes(<minecraft:blaze_powder>);

StoneKiln.removeRecipes(<minecraft:netherbrick>);

PitKiln.removeRecipes(<minecraft:netherbrick>);

BrickCrucible.addRecipe("lime_slurry_from_slaked_lime", <liquid:slaked_lime> * 1000, <contenttweaker:slakedlime_block>, 5 * 60 * 20);

IroncladAnvil.addRecipe("nugget_from_ingot_1", <plustic:mirionnugget>*9, <ore:ingotMirion>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_2", <taiga:tiberium_nugget>*9, <ore:ingotTiberium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_3", <taiga:aurorium_nugget>*9, <ore:ingotAurorium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_4", <taiga:prometheum_nugget>*9, <ore:ingotPrometheum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_5", <taiga:duranite_nugget>*9, <ore:ingotDuranite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_6", <taiga:valyrium_nugget>*9, <ore:ingotValyrium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_7", <taiga:vibranium_nugget>*9, <ore:ingotVibranium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_8", <taiga:karmesine_nugget>*9, <ore:ingotKarmesine>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_9", <botania:manaresource:17>*9, <ore:ingotManasteel>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_10", <botania:manaresource:18>*9, <ore:ingotTerrasteel>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_11", <botania:manaresource:19>*9, <ore:ingotElvenElementium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_12", <contenttweaker:silicon_nugget>*9, <ore:itemSilicon>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_13", <contenttweaker:magnesium_nugget>*9, <ore:ingotMagnesium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_14", <contenttweaker:tungsten_nugget>*9, <contenttweaker:tungsten_ingot>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_15", <draconicevolution:nugget>*9, <ore:ingotDraconium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_16", <draconicevolution:nugget:1>*9, <ore:ingotDraconiumAwakened>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_17", <immersiveengineering:metal:21>*9, <ore:ingotAluminum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_18", <immersiveengineering:metal:22>*9, <ore:ingotLead>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_19", <immersiveengineering:metal:24>*9, <ore:ingotSilver>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_20", <immersiveengineering:metal:23>*9, <ore:ingotNickel>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_21", <immersiveengineering:metal:25>*9, <ore:ingotUranium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_22", <immersiveengineering:metal:26>*9, <ore:ingotConstantan>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_23", <immersiveengineering:metal:27>*9, <ore:ingotElectrum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_24", <mekanism:nugget>*9, <ore:ingotRefinedObsidian>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_25", <mekanism:nugget:1>*9, <ore:ingotOsmium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_26", <mekanism:nugget:3>*9, <ore:ingotRefinedGlowstone>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_27", <plustic:alumitenugget>*9, <ore:ingotAlumite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_28", <taiga:ovium_nugget>*9, <ore:ingotOvium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_29", <taiga:obsidiorite_nugget>*9, <ore:ingotObsidiorite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_30", <taiga:dilithium_nugget>*9, <ore:ingotDilithium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_31", <tconstruct:nuggets>*9, <ore:ingotCobalt>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_32", <tconstruct:nuggets:1>*9, <ore:ingotArdite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_33", <tconstruct:nuggets:2>*9, <ore:ingotManyullyn>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_34", <tconstruct:nuggets:3>*9, <ore:ingotKnightslime>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_35", <tconstruct:nuggets:5>*9, <ore:ingotAlubrass>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_36", <taiga:jauxum_nugget>*9, <ore:ingotJauxum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_37", <taiga:terrax_nugget>*9, <ore:ingotTerrax>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_38", <taiga:palladium_nugget>*9, <ore:ingotPalladium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_39", <taiga:uru_nugget>*9, <ore:ingotUru>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_40", <taiga:osram_nugget>*9, <ore:ingotOsram>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_41", <taiga:abyssum_nugget>*9, <ore:ingotAbyssum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_42", <taiga:triberium_nugget>*9, <ore:ingotTriberium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_43", <taiga:eezo_nugget>*9, <ore:ingotEezo>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_44", <taiga:fractum_nugget>*9, <ore:ingotFractum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_45", <taiga:violium_nugget>*9, <ore:ingotViolium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_46", <taiga:proxii_nugget>*9, <ore:ingotProxii>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_47", <taiga:tritonite_nugget>*9, <ore:ingotTritonite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_48", <taiga:ignitz_nugget>*9, <ore:ingotIgnitz>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_49", <taiga:imperomite_nugget>*9, <ore:ingotImperomite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_50", <taiga:solarium_nugget>*9, <ore:ingotSolarium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_51", <taiga:nihilite_nugget>*9, <ore:ingotNihilite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_52", <taiga:adamant_nugget>*9, <ore:ingotAdamant>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_53", <taiga:dyonite_nugget>*9, <ore:ingotDyonite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_54", <taiga:nucleum_nugget>*9, <ore:ingotNucleum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_55", <taiga:lumix_nugget>*9, <ore:ingotLumix>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_56", <taiga:seismum_nugget>*9, <ore:ingotSeismum>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_57", <taiga:astrium_nugget>*9, <ore:ingotAstrium>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_58", <taiga:niob_nugget>*9, <ore:ingotNiob>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_59", <taiga:yrdeen_nugget>*9, <ore:ingotYrdeen>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_60", <taiga:iox_nugget>*9, <ore:ingotIox>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_61", <taiga:meteorite_nugget>*9, <ore:ingotMeteorite>, 20, "hammer");
IroncladAnvil.addRecipe("nugget_from_ingot_62", <taiga:basalt_nugget>*9, <ore:ingotBasalt>, 20, "hammer");
IroncladAnvil.addRecipe("meteoritecobble_from_meteorite_block", <taiga:meteoritecobble_block>, <taiga:meteorite_block>, 30, "hammer");
IroncladAnvil.addRecipe("obsidioritecobble_block_from_meteorite_block", <taiga:obsidioritecobble_block>, <taiga:obsidiorite_block>, 40, "hammer");
IroncladAnvil.addRecipe("obsidian_from_basalt", <contenttweaker:obsidian_nomana>, <contenttweaker:basalt_coaltar>, 50, "hammer");
IroncladAnvil.addRecipe("steel_plate_from_block", <immersiveengineering:metal:38>*3, <ore:blockSteel>, 27, "hammer");

GraniteAnvil.addRecipe("nugget_from_ingot_63", <minecraft:gold_nugget>*9, <ore:ingotGold>, 10, "hammer", true);
GraniteAnvil.addRecipe("nugget_from_ingot_65", <mekanism:nugget:5>*9, <ore:ingotCopper>, 10, "hammer", true);
GraniteAnvil.addRecipe("nugget_from_ingot_66", <mekanism:nugget:6>*9, <ore:ingotTin>, 10, "hammer", true);
GraniteAnvil.addRecipe("nugget_from_ingot_67", <mekanism:nugget:2>*9, <ore:ingotBronze>, 10, "hammer", true);
GraniteAnvil.addRecipe("copper_plate_from_block", <immersiveengineering:metal:30>*3, <ore:blockCopper>, 27, "hammer", true);
GraniteAnvil.addRecipe("gold_plate_from_block", <immersiveengineering:metal:40>*3, <ore:blockGold>, 27, "hammer", true);

//2021.8.27

Worktable.buildShaped(<artisanworktables:workstation:5>, [
[<pyrotech:material:16>, <ore:plateCopper>, <pyrotech:material:16>],
[<ore:blockCopper>, <pyrotech:stash_stone>, <ore:blockCopper>],
[<chisel:basalt2:7>, <pyrotech:masonry_brick_block>, <chisel:basalt2:7>]
]
)
.setName("custom_recipe_workstation5")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 20)
.register();

Worktable.buildShaped(<artisanworktables:workstation:14>, [
[<pyrotech:material:16>, <minecraft:brick>, <pyrotech:material:16>],
[<minecraft:brick_block>, <pyrotech:stash_stone>, <minecraft:brick_block>],
[<chisel:basalt2:7>, <pyrotech:masonry_brick_block>, <chisel:basalt2:7>]
])
.setName("custom_recipe_workstation14")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 30)
.register();

Worktable.buildShaped(<pyrotech:drying_rack:1>, [
[<ore:stickWood>, <ore:twine>, <ore:stickWood>],
[<ore:twine>, <pyrotech:drying_rack>, <ore:twine>],
[<ore:stickWood>, <ore:twine>, <ore:stickWood>]
])
.setName("custom_recipe_drying_rack1")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

//2021.9.2
SoakingPot.addRecipe("basalt_block_from_basalt", <contenttweaker:basalt_coaltar>, <liquid:coal_tar>, <taiga:basalt_block>, true, 10 * 60 * 20);

//2022.1.29
StoneCrucible.addRecipe("liquid_dirt_from_dirt", <liquid:dirt> * 500, <ore:dirt>, 3 * 60 * 20, true);

//2022.2.7
SoakingPot.addRecipe("sugar_from_sugarcane", <contenttweaker:sugar>, <liquid:sugarcane>, <pyrotech:material:8>, true, 5 * 60 * 20);
StoneCrucible.addRecipe("liquid_sugarcane_from_sugarcane", <liquid:sugarcane> * 500, <ore:sugarcane>, 2 * 60 * 20, true);

Worktable.buildShaped(<immersiveengineering:tool>, [
[null, <pyrotech:material:16>, <ore:twine>],
[null, <tconstruct:tool_rod>.withTag({Material: "copper"}), <pyrotech:material:16>],
[<tconstruct:tool_rod>.withTag({Material: "copper"}), null, null]
])
.setRecipeGameStages(Stages.and(["greenhand"]))
.setName("iehammer")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

Worktable.buildShaped(<minecraft:ladder>, [
[<ore:stickWood>, <ore:twine>, <ore:stickWood>],
[<ore:stickWood>, <ore:stickWood>, <ore:stickWood>],
[<ore:stickWood>, <ore:twine>, <ore:stickWood>]
])
.setRecipeGameStages(Stages.and(["greenhand"]))
.setName("beforeladder")
.setTool(<pyrotech:bone_hammer> | <pyrotech:flint_hammer> | <pyrotech:diamond_hammer> | <pyrotech:iron_hammer> | <pyrotech:gold_hammer>, 10)
.register();

for recipe in recipes.all {
if (recipe.resourceDomain == "pyrotech") {
var recipelocation = recipe.fullResourceDomain;
Worktable.whitelistVanillaRecipes([recipelocation]);}
}