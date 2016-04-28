if !exists('did_perl_local_syntax')
  function MyPerlSub(file)
    echo substitute(substitute(a:file,'$','.pm','g'),'::','/','g')
    return substitute(substitute(a:file,'$','.pm','g'),'::','/','g')
  endfunction
  let did_perl_local_syntax = 1
endif

set isfname+=:

set include=^\\s*use\\>
set includeexpr=MyPerlSub(v:fname)
set path=
execute 'set path+=' . substitute(expand('/usr/lib/perl5'),          '\n', ',', 'g')
execute 'set path+=' . substitute(expand('/usr/share/perl5'),        '\n', ',', 'g')
execute 'set path+=' . substitute(expand('/usr/lib/perl/[0-9]*'),   '\n', ',', 'g')
execute 'set path+=' . substitute(expand('/usr/share/perl/[0-9]*'), '\n', ',', 'g')
"set path+=/usr/lib/perl5/site_perl,.
set path+=.
