del full_releasenotes.txt
for /R %%F in (releasenotes.txt) do @type %%F >> full_releasenotes.txt & echo. >> full_releasenotes.txt