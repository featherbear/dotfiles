alias cse="ssh [USERNAME_GOES_HERE]@wagner.cse.unsw.edu.au -t  'cd ~; bash'"

function viewMDSubmission() {
  # $1 - assignment
  # $2 - student id
  
  # if $1 missing, show all possible assignments
  # if $2 missing, show all possible student IDs
  
  
  if [ -z $1 ];
  then
    ls -1d ~cs6447/21T2.work/*/ | grep -v db.sms |  xargs -L 1 basename;
    return
  fi

  if [ $2 ];
  then
    tar -xOf ~cs6447/21T2.work/$1/all/$2/submission.tar | bat --tabs 2 --file-name "z$2 - $1" -l md --theme OneHalfDark
  else
    ls -1d ~cs6447/21T2.work/$1/all/*/ | xargs -L 1 basename
  fi
}
