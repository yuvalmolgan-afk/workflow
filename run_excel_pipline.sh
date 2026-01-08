#!/bin/bash
#the excel path provided
EXCEL="$1"
# check if path is provided
if [ -z "$EXCEL" ]; then
  echo "Usage: ./run_excel_pipeline.sh params.xlsx"
  exit 1
fi

python3 excel_to_rows.py "$EXCEL" | while read A B IMAGE
do
  echo "Processing row: $A $B $IMAGE"

  RESULT=$(Rscript analysis.R "$A" "$B" | python3 process.py)

  echo "Computed value: $RESULT"

  ./image_process.sh "$IMAGE" "$RESULT"
  echo "----------------------------"
done
#piping R to python