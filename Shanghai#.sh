#!/bin/bash
#*************************************************************************************************************
#*******************Created and tested by Ali Bahkali*********************************************************
#******************This code can be used at your own risk. No warranty of any sort should be provided*********
#*************************************************************************************************************

FIELDS=(
"mathematics" 
"physics" 
"chemistry" 
"earth-sciences" 
"geography" 
"ecology" 
"oceanography" 
"atmospheric-science" 
"mechanical-engineering" 
"electrical-electronic-engineering" 
"automation-control" 
"telecommunication-engineering" 
"instruments-science-technology"
"biomedical-engineering"
"computer-science-engineering"
"civil-engineering"
"chemical-engineering"
"materials-science-engineering"
"nanoscience-nanotechnology"
"energy-science-engineering"
"environmental-science-engineering"
"water-resources"
"food-science-technology"
"biotechnology"
"aerospace-engineering"
"marine-ocean-engineering"
"transportation-science-technology"
"remote-sensing"
"mining-mineral-engineering"
"metallurgical-engineering"
"biological-sciences"
"human-biological-sciences"
"agricultural-sciences"
"veterinary-sciences"
"clinical-medicine"
"public-health"
"dentistry-oral-sciences"
"nursing"
"medical-technology"
"pharmacy-pharmaceutical-sciences"
"economics"
"statistics"
"law"
"political-sciences"
"sociology"
"education"
"communication"
"psychology"
"business-administration"
"finance"
"management"
"public-administration"
"hospitality-tourism-management"
"library-information-science"
)

declare -i {Up,Ud,Sp,Sd}
    Up=501
    Ud=500
    Sp=101
    Sd=100
    re='^[0-9]+$';
    
 UserName="logarithm"
 Fields="/home/$UserName/shanghai/Fields/"
 FieldsTotal=${#FIELDS[@]}
 Universities="/home/$UserName/shanghai/Universities/"
# //Check and Write headers of the "Not Found" Universities to cvs file 
if [ ! -f "$Fields""NotFound.csv" ]; then ( echo "Name#Site#Field" > "$Fields""NotFound.csv"); fi
echo "#ALL RANKING############US RANKING############UK RANKING#########################" > SUMMARY.csv;

echo "FIELD#TOTAL#Total_Available#Total_Helpful_Between#&#Helpful_Ratio_between#&#A#B#C#D#E#F#TOTAL#Total_Available#Total_Helpful_Between#&#Helpful_Ratio_between#&#A#B#C#D#E#F#TOTAL#Total_Available#Total_Helpful_Between#&#Helpful_Ratio_between#&#A#B#C#D#E#F#" >> SUMMARY.csv;

Measures=("AVERAGE" "MIN" "MAX")
chars=( {A..Z} )
s=36
    for Measure in ${Measures[@]}; do echo >> SUMMARY.csv; printf "$Measure#" >> SUMMARY.csv
        for ((i=0; i<s; i++)) do if [[ $i -lt 26 ]]; then(printf "=$Measure(${chars[i+1]}6:${chars[i+1]}$(($FieldsTotal+6)))#" >> SUMMARY.csv); 
        else(printf "=$Measure(A${chars[i-25]}6:A${chars[i-25]}$(($FieldsTotal+6)))#" >> SUMMARY.csv); fi; done; done;

 
for FIELD in ${FIELDS[@]};
do 
    echo $FIELD;
    rm -f $FIELD.csv
    declare -i {K,m,n,SPACE}
    m=0
    n=0
#   // write headers to CSV file    
    if [ ! -f "$Fields""$FIELD" ]; then ( curl "http://www.shanghairanking.com/Shanghairanking-Subject-Rankings/$FIELD.html" > "$Fields""$FIELD" ); fi
    bgfd=$(tr '[:space:]' '[\n*]' < "$Fields""$FIELD" | grep -i -c bgfd)
    bgf5=$(tr '[:space:]' '[\n*]' < "$Fields""$FIELD" | grep -i -c bgf5)
    Lines=$(($bgfd+$bgf5))
    SPACE=$((13+1))
    echo "###$FIELD###US_Ranking#######UK_Ranking" >> $FIELD.csv
    echo "A#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"A\")##Specialty < $Sp & University < $Up###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"AUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"AUK\")" >> $FIELD.csv
    
    echo "B#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"B\")##Specialty > $Sd & University < $Up###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"BUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"BUK\")" >> $FIELD.csv
    
    echo "C#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"C\")##Specialty < $Sp & University > $Ud###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"CUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"CUK\")" >> $FIELD.csv
    
    echo "D#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"D\")##Specialty > $Sd & University > $Ud###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"DUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"DUK\")" >> $FIELD.csv
    
    echo "E#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"E\")##Specialty < $Sp & University is not available###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"EUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"EUK\")" >> $FIELD.csv
    
    echo "F#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"F\")##Specialty > $Sd  & University is not available###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"FUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"FUK\")" >> $FIELD.csv
    
    echo "#$Lines##Total_Number_Of_Universities###=SUM(G2:G7)#######=SUM(N2:N7) " >> $FIELD.csv
    echo "#=SUM(B2:B5)##Total_University_Ranking_Available###=SUM(G2:G5)#######=SUM(N2:N5)" >> $FIELD.csv
    echo "=B6#&#=B6+B4#Total_Helpful_Specialty_Ranking_between###=G6#&#=G6+G4#####=N6#&#=N6+N4" >> $FIELD.csv
    echo "=B6/B8#&#=(B6+B4)/B8#Helpful_Ratio_between###=G6/G8#&#=(G6+G4)/G8#####=N6/N8#&#=(N6+N4)/N8" >> $FIELD.csv
    echo  >> $FIELD.csv
    echo "Rmin#Rmax#Rank#Name#Country#Test#TestUSUK#19min#19max#2019#2018#2017#2016#2015#2014#2013#2012#2011#2010#2009#2008#2007#2006#2005#2004#2003" >> $FIELD.csv


#     // Go over all the list
    while [ $n -lt $Lines ] 
    do 
        echo $n
        K=$(($n+$SPACE))
        
#         // University Rank; # starts with 2 and adds 14
        Rank=$(cat "$Fields""$FIELD" | grep _blank | cut -d "=" -f$((2+$n*14))  | cut -d '>' -f3 |cut -d '<' -f1 )

        Rmin=$(echo $Rank | cut -d'-' -f1)

        Rmax=$(echo $Rank | cut -d'-' -f2)

#         // University Name; # starts with 5 and adds 14
        Name=$(cat "$Fields""$FIELD" | grep _blank | cut -d "=" -f$((5+$n*14))| cut -d '>' -f2| cut -d '<' -f1)

#         // University Site; # starts with 5 and adds 14
        Site=$(cat "$Fields""$FIELD" | grep _blank | cut -d "=" -f$((5+$n*14))| cut -d '<' -f1 | cut -d '"' -f2 | cut -d '/' -f3)

#         // Country;  # starts with 7 and adds 14
        Country=$(cat "$Fields""$FIELD" | grep _blank | cut -d "=" -f$((7+$n*14)) | cut -d ">" -f1)
        
#         // get University page (but not when it is already exists (-nc option)
        Test=$(echo "=IF(AND(ISNUMBER(A$K);ISNUMBER(H$K));(IF(AND(A$K>$Sd;H$K<$Ud);\"B\";IF(AND(A$K<$Sp;H$K>$Ud);\"C\";IF(AND(A$K<$Sp;H$K<$Up);\"A\";\"D\"))));(IF(OR(ISNUMBER(A$K);ISNUMBER(H$K));(IF(OR(A$K<$Sp;H$K<$Up);\"E\";\"F\")))))")
        TestUSUK=$(echo "=IF(E$K=\" United States\";IF(F$K=\"A\";\"AUS\";IF(F$K=\"B\";\"BUS\";IF(F$K=\"C\";\"CUS\";IF(F$K=\"D\";\"DUS\";IF(F$K=\"E\";\"EUS\";\"FUS\")))));IF(E$K=\" United Kingdom\";IF(F$K=\"A\";\"AUK\";IF(F$K=\"B\";\"BUK\";IF(F$K=\"C\";\"CUK\";IF(F$K=\"D\";\"DUK\";IF(F$K=\"E\";\"EUK\";\"FUK\")))))))")
                     
         if [ ! -f "$Universities$Site" ] &&  ! grep -q "$Site" $Fields"NotFound.csv"; then (wget -P $Universities "http://www.shanghairanking.com/World-University-Rankings/$Site"); fi 
    
         
        if [ ! -f "$Universities$Site" ] &&  ! grep -q  "$Name" "$Fields""NotFound.csv";  then (echo "$Name#$Site#$FIELD" >> "$Fields""NotFound.csv"); fi
        
        
        if [ ! -f "$Universities$Site" ] &&   grep -q  "$Name" "$Fields""NotFound.csv";  then (echo "$Name"; rm -f "$Fields""Search.jsp"; wget -P $Fields --post-data  universitySearch="$Name" "http://www.shanghairanking.com/Search.jsp"; NewSite=$(cat "$Fields""Search.jsp" | grep "$Name" | cut -d'/' -f2| cut -d'"' -f1); if [[ "$NewSite" ]] && wget --spider "http://www.shanghairanking.com/World-University-Rankings/$NewSite"; then (echo $NewSite; Site=$(echo "$NewSite"); sed -i "/$Name/d" "$Fields""NotFound.csv"; wget -nc --no-use-server-timestamps -P $Universities "http://www.shanghairanking.com/World-University-Rankings/$NewSite") fi ); fi

          #      // University Ranking; # starts with 3 and add 4 (up to 67 "$Sp9")
        if [ -f "$Universities$Site" ]; then (for ((i=3; i<20; i++)); do y[i]=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f$((3+$(( i-3 ))*4)) | cut -d '<' -f1);  done
        
        y19min=$( echo $[y[19]] | cut -d'-' -f1)
        y19max=$( echo $[y[19]] | cut -d'-' -f2)
        # NOTE="${a//[$'\t\r\n ']}";      
echo "$Rmin#$Rmax#$Rank#$Name#$Country#$Test#$TestUSUK#$y19min#$y19max" >> $FIELD.csv
for ((i=3; i<20; i++)); do printf '#'${y[i]} >> $FIELD.csv; done
       else (echo "$Rmin#$Rmax#$Rank#$Name#$Country#$Test#$TestUSUK" >> $FIELD.csv); fi
        n=$(($n+1));
    done
    echo >> SUMMARY.csv
    printf "$FIELD#$Lines#" >> SUMMARY.csv
    Cells=(B9 A10 C10 A11 C11 B2 B3 B4 B5 B6 B7 G8 G9 G10 I10 G11 I11 G2 G3 G4 G5 G6 G7 N8 N9 N10 P10 N11 P11 N2 N3 N4 N5 N6 N7);
    for Cell in ${Cells[@]}; do printf "='$FIELD'.$Cell#" >> SUMMARY.csv; done
   
   echo "********************** Done $FIELD ********************"
done


# *************OpenOffice Calc Macro to rename Sheets*********** 
# *************Created by Ali Bahkali.**************************
# Sub Main
#    Dim mSheet
#    Dim mCell
#    Dim i
#    
#    For i = 1 to 56
#       mSheet = ThisComponent.Sheets(i)
#       mCell = mSheet.getCellRangeByName("D1")
#       mSheet.Name = mCell.String
#    Next i
# End Sub
