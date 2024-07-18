#!/bin/sh 

usage() { 
    echo "Usage: $0 "'-d "your_input_data_delimiter_character" -t "My Title" -h "My Header"' 1>&2 
    exit 1 
}

IFS_CHAR=" "
MY_TITLE="MY_TITLE"
MY_HEADER="MY_HEADER"

while getopts "d:t:h:" inp; do
    case "${inp}" in
        d)
            IFS_CHAR=${OPTARG}
            ;;
        t)
            MY_TITLE=${OPTARG}
            ;;
        h)
            MY_HEADER=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

echo '<!DOCTYPE html>'
echo '<html>'
echo '<head>'
echo '<meta name="viewport" content="width=device-width, initial-scale=1" charset="ISO-8859-1">'
echo '<title>'$MY_TITLE'</title>'
echo '<style type="text/css">
table, th, td {
    border: 1px solid black;
}
tr:first-child {
    font-weight: bold;
}
tr:nth-child(even) {background: #eef}
tr:nth-child(odd) {background: #fee}
* {
    box-sizing: border-box;
}
#myTable {
    border-collapse: collapse;
    border: 1px solid #ddd;
    width: 100%;
    margin-top: 18px;
}
#myTable th, #myTable td {
    text-align: left;
    padding: 12px;
}
#myTable tr {
    border-bottom: 1px solid #ddd;
}
#myTable tr:first-child:hover, #myTable tr:hover {
    background-color: DarkKhaki;
}
#myTable tr:first-child {
    background-color: DarkKhaki;
    font-weight: bold;
}
</style>'
echo '</head>'
echo '<body>'
echo '<h2 style="text-align:center;background-color:DodgerBlue;color:White;">'$MY_HEADER'</h2>'
echo '<table id="myTable">'

# Column headers (customize as per your data)
#echo '<tr>'
#echo '<th>IP</th>'
#echo '<th>SERVERNAME</th>'
#echo '<th>CPUs</th>'
#echo '<th>CPU SPEED</th>'
#echo '<th>UPTIME</th>'
#echo '<th>LOAD AVERAGE</th>'
#echo '<th>TOTAL MEMORY</th>'
#echo '<th>USED MEMORY</th>'
#echo '<th>FREE MEMORY</th>'
#echo '</tr>'

# Read and process CSV data
cat - | sed '/^$/d' | awk -F "$IFS_CHAR" -v header=1 'BEGIN {OFS="\t";}
{
    print "\t<tr>"
    for(f = 1; f <= NF; f++) {
        if (NR == 1 && header) {
            printf "\t\t<th>%s</th>\n", $f
        } else {
            printf "\t\t<td>%s</td>\n", $f
        }
    }
    print "\t</tr>"
}
END {
    print "</table></body></html>"
}'
