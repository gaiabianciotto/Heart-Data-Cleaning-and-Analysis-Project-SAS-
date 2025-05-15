/*Scenarii 6C*/

libname myxls xlsx '/home/u64206886/heart.xlsx'; /*task1: read heart.xlsx using xlsx engine*/

data work.heart;
    set myxls.heart;

    drop ageAtDeath deathCause; /*task2: drop ageAtDeath and deathCause variables*/

    if status = 'Alive' and not missing(ageCHDDiag); /*task3: keep only observations where status = "Alive" & task4: discard missing ageCHDDiag*/

    length smokingStatus $19; /*task5: create a new variable smokingStatus with length 19*/

/*task5 criteria:*/
    if 0 <= smoking < 7 then smokingStatus = '1-None (0-6)'; 
    else if 7 <= smoking <= 15 then smokingStatus = '2-Moderate (7-15)'; 
    else if 16 <= smoking <= 25 then smokingStatus = '3-Heavy (16-25)'; 
    else if smoking > 25 then smokingStatus = '4-Very Heavy (>25)'; 
    else smokingStatus = 'Error'; 

/*task6: create a two-way frequency table without percentages*/
proc freq data=work.heart;
    tables ageCHDDiag * smokingStatus / norow nocol nopercent;
run;
