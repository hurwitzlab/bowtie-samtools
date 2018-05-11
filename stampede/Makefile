APP = bowtie-samtools-0.0.1
EMAIL = scottdaniel@email.arizona.edu
CLI = ~/agave-cli/bin

clean:
	find . \( -name \*.out -o -name \*.param \) -exec rm {} \;

up:
	copy_from_manifest.py

app:
	$(CLI)/apps-addupdate -F app.json

test: clean
	sbatch test.sh

jobs-template:
	$(CLI)/jobs-template -A $(APP) > job.json

jobs-submit:
	$(CLI)/jobs-submit -F job.json

list:
	$(CLI)/files-list -L -S data.iplantcollaborative.org scottdaniel/applications/$(APP)/stampede
