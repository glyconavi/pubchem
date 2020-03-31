<?php
$file_path = 'selectedCT.txt';

$file = new SplFileObject($file_path, 'r');

$fp = fopen('ct.txt', 'w');

while ($file->valid()) {
    $row = $file->fgetcsv("\t", '"');
    $count = count($row);
    $i = 0; 
    while($i < $count) {
        echo $i.":\t".$row[$i]."\t";
        if ($i==0){

            fwrite($fp, "ID:".$row[$i]."\n");
        }
        else {
            fwrite($fp, $row[$i]."\n");
        }
        ++$i;
    }
    fwrite($fp, "\n");
    echo "\n";
}

fclose($fp);

?>
