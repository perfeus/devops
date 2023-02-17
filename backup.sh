#!/bin/bash

# Check if all parameters are provided
if [ $# -ne 3 ]; then
	echo "Usage: $0 directory_to_backup compression_algorithm output_file_name"
	exit 1
fi

# Assign parameters values to variables
DIR_BACKUP=$1
COMPRES_ALG=$2
OUTPUT_FILE=$3

if [[ $COMPRES_ALG == "gzip" ]] || [[ $COMPRES_ALG == "bzip" ]] || [[ $COMPRES_ALG == "xz" ]]; then
	case $COMPRES_ALG in
		gzip)
			tar czf auxulary.gz "$DIR_BACKUP"
			openssl aes-256-cbc -pbkdf2 -salt -in auxulary.gz -out "$OUTPUT_FILE"
			echo "Backup completed successfully and saved to $OUTPUT_FILE";;
		bzip)
			tar cjf auxulary.bz2 "$DIR_BACKUP"
			openssl aes-256-cbc -pbkdf2 -salt -in auxulary.bz2 -out "$OUTPUT_FILE"
			echo "Backup completed successfully and saved to $OUTPUT_FILE";;
		*)
			tar cJF auxulary.xz "$DIR_BACKUP"
			openssl aes-256-cbc -pbkdf2 -salt -in auxulary.xz -out "$OUTPUT_FILE"
			echo "Backup completed successfully and saved to $OUTPUT_FILE"
	esac
else
	echo "$COMPRES_ALG is not supported"
fi

			
exec 1> /dev/null
exec 2> error.log

# Print a success message
echo "Backup completee successfully and saved to $OUTPUT_FILE"

