#!/bin/bash
#*************************************************************************************************************
#*******************Created and tested by Ali Bahkali. College of Nursing, Jazan University*******************
#******************This code can be used at your own risk. No warranty of any sort should be provided*********

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


# //Check and Write headers of the "Not Found" Universities to cvs file 
if [ ! -f "NotFound.csv" ]; then ( echo "Name#Site#Field" > NotFound.csv ); fi

echo "FIELD#TOTAL#Total_Available#Total_Helpful_Between#&#Helpful_Ratio_between#&#A#B#C#D#E#F#US_RANKING#TOTAL#Total_Available#Total_Helpful_Between#&#Helpful_Ratio_between#&#A#B#C#D#E#F#UK_RANKING#TOTAL#Total_Available#Total_Helpful_Between#&#Helpful_Ratio_between#&#A#B#C#D#E#F#" >> SUMMARY.csv

# echo "=B9#=A10#=C10#=A11#=C11#=B2#=B3#=B4#=B5#=B6#=B7#*#=G8#=G9#=G10#=I10#=G11#=I11#=G2#=G3#=G4#=G5#=G6#=G7#*#=N8#=N9#=N10#=P10#=N11#=P11#=N2#=N3#=N4#=N5#=N6#=N7"
  
for FIELD in ${FIELDS[@]};
do 
    echo $FIELD;
    rm -f $FIELD.csv
    declare -i {K,m,n,SPACE}
    m=0
    n=0
    re='^[0-9]+$';
#   // write headers to CSV file    
    if [ ! -f "$FIELD" ]; then ( curl "http://www.shanghairanking.com/Shanghairanking-Subject-Rankings/$FIELD.html" > $FIELD ); fi
    Universities="/home/{$USER}/shanghai/Universities/"
    bgfd=$(tr '[:space:]' '[\n*]' < $FIELD | grep -i -c bgfd)
    bgf5=$(tr '[:space:]' '[\n*]' < $FIELD | grep -i -c bgf5)
    Lines=$(($bgfd+$bgf5))
    SPACE=$((13+1))
    echo "###$FIELD###US_Ranking#######UK_Ranking" >> $FIELD.csv
    echo "A#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"A\")##Specialty < 201 & University < 501###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"AUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"AUK\")" >> $FIELD.csv
    echo "B#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"B\")##Specialty > 200 & University < 501###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"BUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"BUK\")" >> $FIELD.csv
    echo "C#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"C\")##Specialty < 201 & University > 500###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"CUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"CUK\")" >> $FIELD.csv
    echo "D#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"D\")##Specialty > 200 & University > 500###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"DUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"DUK\")" >> $FIELD.csv
    echo "E#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"E\")##Specialty < 201 & University is not available###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"EUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"EUK\")" >> $FIELD.csv
    echo "F#=COUNTIF(F$SPACE:F$(($Lines+$SPACE));\"F\")##Specialty > 200  & University is not available###=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"FUS\")#######=COUNTIF(G$SPACE:G$(($Lines+$SPACE));\"FUK\")" >> $FIELD.csv
    echo "#$Lines##Total_Number_Of_Universities###=SUM(G2:G7)#######=SUM(N2:N7) " >> $FIELD.csv
    echo "#=SUM(B2:B5)##Total_University_Ranking_Available###=SUM(G2:G5)#######=SUM(G2:G5)" >> $FIELD.csv
    echo "=B6#&#=B6+B4#Total_Helpful_Specialty_Ranking_between###=G6#&#=G6+G4#####=N6#&#=N6+N4" >> $FIELD.csv
    echo "=B6/B8#&#=(B6+B4)/B8#Helpful_Ratio_between###=G6/G8#&#=(G6+G4)/G8#####=N6/N8#&#=(N6+N4)/N8" >> $FIELD.csv
    echo "=B9#=A10#=C10#=A11#=C11#=B2#=B3#=B4#=B5#=B6#=B7#*#=G8#=G9#=G10#=I10#=G11#=I11#=G2#=G3#=G4#=G5#=G6#=G7#*#=N8#=N9#=N10#=P10#=N11#=P11#=N2#=N3#=N4#=N5#=N6#=N7" >> $FIELD.csv
    echo "Rmin#Rmax#Rank#Name#Country#Test#TestUSUK#19min#19max#2019#2018#2017#2016#2015#2014#2013#2012#2011#2010#2009#2008#2007#2006#2005#2004#2003" >> $FIELD.csv


#     // Go over all the list
    while [ $n -lt $Lines ]
    do 
        echo $n
        K=$(($n+$SPACE))
#         // University Rank; # starts with 2 and adds 14
        Rank=$(cat $FIELD | grep _blank | cut -d "=" -f$((2+$n*14))  | cut -d '>' -f3 |cut -d '<' -f1 )
#         echo {Rank,$Rank}
        Rmin=$(echo $Rank | cut -d'-' -f1)
#         echo {Rmin,$Rmin}
        Rmax=$(echo $Rank | cut -d'-' -f2)
#         echo {Rmax,$Rmax}
#         // University Name; # starts with 5 and adds 14
        Name=$(cat $FIELD | grep _blank | cut -d "=" -f$((5+$n*14))| cut -d '>' -f2| cut -d '<' -f1)
#         echo {Name,$Name}
#         // University Site; # starts with 5 and adds 14
        Site=$(cat $FIELD | grep _blank | cut -d "=" -f$((5+$n*14))| cut -d '<' -f1 | cut -d '"' -f2 | cut -d '/' -f3)
#         echo {Site,$Site}
#         // Country;  # starts with 7 and adds 14
        Country=$(cat $FIELD | grep _blank | cut -d "=" -f$((7+$n*14)) | cut -d ">" -f1)
#         echo {Country,$Country}
#         // get University page (but not when it is already exists (-nc option)
        Test=$(echo "=IF(AND(ISNUMBER(A$K);ISNUMBER(H$K));(IF(AND(A$K>200;H$K<500);\"B\";IF(AND(A$K<201;H$K>501);\"C\";IF(AND(A$K<201;H$K<501);\"A\";\"D\"))));(IF(OR(ISNUMBER(A$K);ISNUMBER(H$K));(IF(OR(A$K<201;H$K<501);\"E\";\"F\")))))")
        TestUSUK=$(echo "=IF(E$K=\" United States\";IF(F$K=\"A\";\"AUS\";IF(F$K=\"B\";\"BUS\";IF(F$K=\"C\";\"CUS\";IF(F$K=\"D\";\"DUS\";IF(F$K=\"E\";\"EUS\";\"FUS\")))));IF(E$K=\" United Kingdom\";IF(F$K=\"A\";\"AUK\";IF(F$K=\"B\";\"BUK\";IF(F$K=\"C\";\"CUK\";IF(F$K=\"D\";\"DUK\";IF(F$K=\"E\";\"EUK\";\"FUK\")))))))")
                     
         if [ ! -f "$Universities$Site" ] &&  ! grep -q "$Site" NotFound.csv; then (wget -P $Universities "http://www.shanghairanking.com/World-University-Rankings/$Site"); fi 
    
         
        if [ ! -f "$Universities$Site" ] &&  ! grep -q  "$Name" NotFound.csv;  then (echo "$Name#$Site#$FIELD" >> NotFound.csv); fi
        
        
        if [ ! -f "$Universities$Site" ] &&   grep -q  "$Name" NotFound.csv;  then (echo "$Name"; rm -f "Search.jsp"; wget --post-data  universitySearch="$Name" "http://www.shanghairanking.com/Search.jsp"; NewSite=$(cat "Search.jsp" | grep "$Name" | cut -d'/' -f2| cut -d'"' -f1); if [[ "$NewSite" ]] && wget --spider "http://www.shanghairanking.com/World-University-Rankings/$NewSite"; then (echo $NewSite; Site=$(echo "$NewSite"); sed -i "/$Name/d" NotFound.csv; wget -nc --no-use-server-timestamps -P $Universities "http://www.shanghairanking.com/World-University-Rankings/$NewSite") fi ); fi

          #      // University Ranking; # starts with 3 and add 4 (up to 67 "2019")
        if [ -f "$Universities$Site" ]; then (
        y19=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f67 | cut -d '<' -f1)
        y19min=$( echo $y19 | cut -d'-' -f1)
        y19max=$( echo $y19 | cut -d'-' -f2)
        y18=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f63 | cut -d '<' -f1)
        y17=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f59 | cut -d '<' -f1)
        y16=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f55 | cut -d '<' -f1)
        y15=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f51 | cut -d '<' -f1)
        y14=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f47 | cut -d '<' -f1)
        y13=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f43 | cut -d '<' -f1)
        y12=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f39 | cut -d '<' -f1)
        y11=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f35 | cut -d '<' -f1)
        y10=$(cat $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f31 | cut -d '<' -f1)
        y9=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f27 | cut -d '<' -f1)
        y8=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f23 | cut -d '<' -f1)
        y7=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f19 | cut -d '<' -f1)
        y6=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f15 | cut -d '<' -f1)
        y5=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f11 | cut -d '<' -f1)
        y4=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f7 | cut -d '<' -f1)
        y3=$(cat  $Universities$Site | grep  "<td><a href=\"../ARWU" | cut -d '>' -f3 | cut -d '<' -f1)
       echo "$Rmin#$Rmax#$Rank#$Name#$Country#$Test#$TestUSUK#$y19min#$y19max#$y19#$y18#$y17#$y16#$y15#$y14#$y13#$y12#$y11#$y10#$y9#$y8#$y7#$y6#$y5#$y4#$y3" >> $FIELD.csv);
       else (echo "$Rmin#$Rmax#$Rank#$Name#$Country#$Test#$TestUSUK" >> $FIELD.csv); fi
        n=$(($n+1));

    done
    echo "$FIELD#$Lines" >> SUMMARY.csv
    echo "********************** Done $FIELD ********************"
    
done
