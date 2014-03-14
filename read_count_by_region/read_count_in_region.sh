#this program will output the read count in the region specified in the arguments
#arguments:
#	$1: the location where the bamfiles are stored
#	$2: the region where you are interested in counting the reads || format chr<int>:<int>-<int> OR the gene name
#	$3: if you want to pass options to samtools such as -F4 you can do ONLY ONE option is accepted unless you put them in double quotes
#	

if [[ $2 == *:*-* ]]
then
	cmd="samtools view \$3 \$file \$2 | wc -l"
else
	cmd="samtools view \$3 \$file | grep '\$2' | wc -l"
fi


echo "File name " $'\t' "Region" $'\t' "Total" $'\t\t' "Ratio"
echo "--------------------------------------------------------"
for file in $1*.bam
do
	total=`samtools view $3 $file | wc -l`
	region=`eval $cmd`
	ratio=$(echo "scale=5;$region/$total" | bc)
	echo $(basename $file) $'\t' $region $'\t\t' $total $'\t' $ratio
done
#bash read_count_in_region.sh ~/projects/goodFellow/bam_files/ chr16:67,642,703-67,649,989


#this is the region that I am hoping to find some deletion chr16:67,644,581-67,645,490
#new region more narrowed down chr16:67,644,590-67,645,400
#CMD:  bash read_count_in_region.sh ~/projects/goodFellow/bam_files/ chr16:67,644,581-67,645,490 " -F 4 " > ~/projects/goodFellow/resource/results/region_read_count_chr16-67644581-67645490

#i found it!!
#it was 2313_S69.bam
