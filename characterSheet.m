function [] = characterSheet()
%setting lots of variables 
global sheet;
global intOutput;
intOutput = 0;
global sghOutput;
sghOutput = 0;
global dexOutput;
dexOutput = 0;
global wisOutput;
wisOutput = 0;
global conOutput;
conOutput = 0;
global chaOutput;
chaOutput = 0;
global intBonus;
intBonus = 0;
global sghBonus;
sghBonus = 0;
global dexBonus;
dexBonus = 0;
global wisBonus;
wisBonus = 0;
global conBonus;
conBonus = 0;
global chaBonus;
chaBonus = 0;
global damage12;
damage12 = 0;
global damage10;
damage10 = 0;
global damage8;
damage8 = 0;
global damage6;
damage6 = 0;
global damage4;
damage4 = 0;
global damage2;
damage2 = 0;
%close all existing figures and create a name
close all;
sheet.fig = figure('numbertitl', 'off', 'name', 'Character Sheet');
%setting the text so the user knows what they are looking at 
sheet.int = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.02 .8 .11 .2], 'string', 'Intellignece', 'horizontalalignment', 'right');
sheet.sgh = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.02 .8 .11 .17], 'string', 'Stength', 'horizontalalignment', 'right');
sheet.dex = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.02 .8 .11 .14], 'string', 'Dexterity', 'horizontalalignment', 'right');
sheet.wis = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.02 .8 .11 .11], 'string', 'Wisdom', 'horizontalalignment', 'right');
sheet.con = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.02 .8 .11 .08], 'string', 'Constitution', 'horizontalalignment', 'right');
sheet.cha = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.02 .8 .11 .05], 'string', 'Charisma', 'horizontalalignment', 'right');
%pushbuttons to roll each stat. Each calls back to a different function
sheet.intRoll = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .97 .1 .03], 'string', 'Roll Int', 'callback', {@rollInt});
sheet.sghRoll = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .94 .1 .03], 'string', 'Roll Str', 'callback', {@rollSgh});
sheet.dexRoll = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .91 .1 .03], 'string', 'Roll Dex', 'callback', {@rollDex});
sheet.wisRoll = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .88 .1 .03], 'string', 'Roll Wis', 'callback', {@rollWis});
sheet.conRoll = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .85 .1 .03], 'string', 'Roll Con', 'callback', {@rollCon});
sheet.chaRoll = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .82 .1 .03], 'string', 'Roll Cha', 'callback', {@rollCha});

%just to the right of the pushbuttons. Allows users to add their modifiers
%to each stat individually. All callback to the same function
sheet.intMod = uicontrol('style', 'edit', 'units', 'normalized', 'position',...
    [.25 .97 .10 .03], 'string', '0', 'callback', {@modifier});
sheet.sghMod = uicontrol('style', 'edit', 'units', 'normalized', 'position',...
    [.25 .94 .10 .03], 'string', '0', 'callback', {@modifier});
sheet.dexMod = uicontrol('style', 'edit', 'units', 'normalized', 'position',...
    [.25 .91 .10 .03], 'string', '0', 'callback', {@modifier});
sheet.wisMod = uicontrol('style', 'edit', 'units', 'normalized', 'position',...
    [.25 .88 .10 .03], 'string', '0', 'callback', {@modifier});
sheet.conMod = uicontrol('style', 'edit', 'units', 'normalized', 'position',...
    [.25 .85 .10 .03], 'string', '0', 'callback', {@modifier});
sheet.chaMod = uicontrol('style', 'edit', 'units', 'normalized', 'position',...
    [.25 .82 .10 .03], 'string', '0', 'callback', {@modifier});
%after the user enters their modifier in the editboxes they will show up
%here so they can be kept track of and user for when the user wants to roll
%for a stat
sheet.intBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .2], 'string', num2str(intBonus), 'horizontalalignment', 'left');
sheet.sghBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .17], 'string', num2str(sghBonus), 'horizontalalignment', 'left');
sheet.dexBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .14], 'string', num2str(dexBonus), 'horizontalalignment', 'left');
sheet.wisBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .11], 'string', num2str(wisBonus), 'horizontalalignment', 'left');
sheet.conBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .08], 'string', num2str(conBonus), 'horizontalalignment', 'left');
sheet.chaBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .05], 'string', num2str(chaBonus), 'horizontalalignment', 'left');
%the final result of each roll. The addition of a random integer between 1
%and 20 plus whatever the modifier happens to be. Is the farthest right
%number on the top block
sheet.intResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .2], 'string', num2str(intOutput), 'horizontalalignment', 'left'); 
sheet.sghResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .17], 'string', num2str(sghOutput), 'horizontalalignment', 'left'); 
sheet.dexResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .14], 'string', num2str(dexOutput), 'horizontalalignment', 'left'); 
sheet.wisResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .11], 'string', num2str(wisOutput), 'horizontalalignment', 'left'); 
sheet.conResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .08], 'string', num2str(conOutput), 'horizontalalignment', 'left'); 
sheet.chaResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .05], 'string', num2str(chaOutput), 'horizontalalignment', 'left'); 
 % header for the section of different damages weapons can do. 
sheet.weaponsHeader = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.02 .7 .11 .05], 'string', 'Weapons', 'horizontalalignment', 'right');
%since many weapons deal the same amount of damage I decided to do a common
%range of damages rather than individual weapons which might be redundant.
%similar to GUI used above with a callback to a function and a display of
%that output. This time I didn't allow any modifiers for the weapons. This
%is a drawback but I felt that would be too far outside the scope of this
%project for right now. Additionally, some weapons use roll the same dice
%twice for one damage roll but I felt it would be redundant to include that
sheet.weaponRoll12 = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .7 .1 .05], 'string', '1d12', 'callback', {@rollWeapon12});
%the above gui name is the word roll followed by the number 12. One and 
%lowercase L in MatLab look almost identical so I thought it was worth being explicit here  
sheet.weapon12Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .65 .1 .05], 'string', num2str(damage12), 'horizontalalignment', 'center');
sheet.weaponRoll10 = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.25 .7 .1 .05], 'string', '1d10', 'callback', {@rollWeapon10});
%similar to comment above the names above and below are roll 10 and 10
%Output respectively. I tried to come up with better names for them but
%didn't think of anything that felt particularly right. The names as a
%whole for this project I felt could be confusing and I think it would have
%been helpful to think about how many names I would need and what they would 
%be sooner in the project
sheet.weapon10Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.25 .65 .1 .05], 'string', num2str(damage10), 'horizontalalignment', 'center');
sheet.weaponRoll8 = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.35 .7 .1 .05], 'string', '1d8', 'callback', {@rollWeapon8});
sheet.weapon8Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.35 .65 .1 .05], 'string', num2str(damage8), 'horizontalalignment', 'center');
sheet.weaponRoll6 = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.15 .6 .1 .05], 'string', '1d6', 'callback', {@rollWeapon6});
sheet.weapon6Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .55 .1 .05], 'string', num2str(damage6), 'horizontalalignment', 'center');
sheet.weaponRoll4 = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.25 .6 .1 .05], 'string', '1d4', 'callback', {@rollWeapon4});
sheet.weapon4Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.25 .55 .1 .05], 'string', num2str(damage4), 'horizontalalignment', 'center');
sheet.weaponRoll2 = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position',...
    [.35 .6 .1 .05], 'string', '1d2', 'callback', {@rollWeapon2});
sheet.weapon2Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.35 .55 .1 .05], 'string', num2str(damage2), 'horizontalalignment', 'center');
end 
%modifier function. Calls each global variable needed. Uses a get function
%on the edit box to get the number the user entered and then converts that
%into a number and assigns that as the bonus which will be applied to the
%roll later on.
function [] = modifier(~,~,~)
global intBonus;
global sghBonus;
global dexBonus;
global wisBonus;
global conBonus;
global chaBonus;
global sheet;
intBonus = str2double(get(sheet.intMod,'string'));
sghBonus = str2double(get(sheet.sghMod,'string'));
dexBonus = str2double(get(sheet.dexMod,'string'));
wisBonus = str2double(get(sheet.wisMod,'string'));
conBonus = str2double(get(sheet.conMod,'string'));
chaBonus = str2double(get(sheet.chaMod,'string'));
%these are here to update the text to the right of the editboxes so the
%user knows what their modifier is in case they forget or accidnetally
%erase what is in the editbox
sheet.intBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .2], 'string', num2str(intBonus), 'horizontalalignment', 'left');
sheet.sghBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .17], 'string', num2str(sghBonus), 'horizontalalignment', 'left');
sheet.dexBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .14], 'string', num2str(dexBonus), 'horizontalalignment', 'left');
sheet.wisBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .11], 'string', num2str(wisBonus), 'horizontalalignment', 'left');
sheet.conBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .08], 'string', num2str(conBonus), 'horizontalalignment', 'left');
sheet.chaBonus = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.37 .8 .11 .05], 'string', num2str(chaBonus), 'horizontalalignment', 'left');
end
%the first of my 6 stat roll callback functions. Uses the modifier plus a
%random integer from 1 to 20 to get the roll. result doesn't need to be a
%global since it is only used to find the final output.
function [] = rollInt(~,~,~)
global intBonus;
global sheet;
global intOutput;
intBonus = str2double(get(sheet.intMod,'string'));
result = randi(20,1);
intOutput = result + intBonus;
sheet.intResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .2], 'string', num2str(intOutput), 'horizontalalignment', 'left'); 
end

function [] = rollSgh(~,~,~)
global sghBonus;
global sheet;
global sghOutput;
sghBonus = str2double(get(sheet.sghMod,'string'));
result = randi(20,1);
sghOutput = result + sghBonus;
sheet.sghResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .17], 'string', num2str(sghOutput), 'horizontalalignment', 'left'); 
end

function [] = rollDex(~,~,~)
global dexBonus;
global sheet;
global dexOutput;
dexBonus = str2double(get(sheet.dexMod,'string'));
result = randi(20,1);
dexOutput = result + dexBonus;
sheet.dexResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .14], 'string', num2str(dexOutput), 'horizontalalignment', 'left'); 
end

function [] = rollWis(~,~,~)
global wisBonus;
global sheet;
global wisOutput;
wisBonus = str2double(get(sheet.wisMod,'string'));
result = randi(20,1);
wisOutput = result + wisBonus;
sheet.wisResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .11], 'string', num2str(wisOutput), 'horizontalalignment', 'left'); 
end

function [] = rollCon(~,~,~)
global conBonus;
global sheet;
global conOutput;
conBonus = str2double(get(sheet.conMod,'string'));
result = randi(20,1);
conOutput = result + conBonus;
sheet.conResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .08], 'string', num2str(conOutput), 'horizontalalignment', 'left'); 
end

function [] = rollCha(~,~,~)
global chaBonus;
global sheet;
global chaOutput;
chaBonus = str2double(get(sheet.chaMod,'string'));
result = randi(20,1);
chaOutput = result + chaBonus;
sheet.chaResult = uicontrol ('style', 'text', 'units', 'normalized', 'position',...
    [.4 .8 .11 .05], 'string', num2str(chaOutput), 'horizontalalignment', 'left'); 
end
%first of 6 weapon callback functions. Similar to the stat roll callbacks.
%This time since no modifiers are being used the damage can be directly
%calculated using a randi function. 
function [] = rollWeapon12(~,~,~)
global sheet; 
global damage12;
damage12 = randi(12,1);
sheet.weapon12Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .65 .1 .05], 'string', num2str(damage12), 'horizontalalignment', 'center');
end

function [] = rollWeapon10(~,~,~)
global sheet; 
global damage10;
damage10 = randi(10,1);
sheet.weapon10Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.25 .65 .1 .05], 'string', num2str(damage10), 'horizontalalignment', 'center');
end

function [] = rollWeapon8(~,~,~)
global sheet; 
global damage8;
damage8 = randi(8,1);
sheet.weapon8Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.35 .65 .1 .05], 'string', num2str(damage8), 'horizontalalignment', 'center');
end

function [] = rollWeapon6(~,~,~)
global sheet; 
global damage6;
damage6 = randi(6,1);
sheet.weapon6Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .55 .1 .05], 'string', num2str(damage6), 'horizontalalignment', 'center');
end

function [] = rollWeapon4(~,~,~)
global sheet; 
global damage4;
damage4 = randi(4,1);
sheet.weapon4Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.25 .55 .1 .05], 'string', num2str(damage4), 'horizontalalignment', 'center');
end
function [] = rollWeapon2(~,~,~)
global sheet; 
global damage2;
damage2 = randi(2,1);
sheet.weapon2Output = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.35 .55 .1 .05], 'string', num2str(damage2), 'horizontalalignment', 'center');
end