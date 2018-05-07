APP = bowtie-samtools-0.0.1
EMAIL = scottdaniel@email.arizona.edu

clean:
	find . \( -name \*.out -o -name \*.param \) -exec rm {} \;

up:
	copy_from_manifest.py

app:
	apps-addupdate -F app.json

test: clean
	sbatch test.sh

jobs-template:
	jobs-template -A $(APP) > job.json

jobs-submit:
	jobs-submit -F job.json

list:
	files-list -L -S data.iplantcollaborative.org scottdaniel/applications/$(APP)/stampede
