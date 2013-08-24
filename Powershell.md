#Windows Scripting for scientists

These notes are based on the Bash software carpentry event I helped with in Bath.  [https://github.com/swcarpentry/boot-camps/tree/2013-07-bath/shell](https://github.com/swcarpentry/boot-camps/tree/2013-07-bath/shell).  

I wondered what a similar set of notes might look like in PowerShell - this is the result.  You are free to use them with the following caveats

- This is not necessarily the right way to teach PowerShell. It is an experiment in converting some classroom-tested Linux based notes to PowerShell.  Further experiments are planned.
- Attribution would be nice.  I am Mike Croucher, my site is [www.walkingrandomly.com](http://www.walkingrandomly.com)  Details on how to contact me at [http://www.walkingrandomly.com/?page_id=2055](http://www.walkingrandomly.com/?page_id=2055)
- I have not yet tested these notes in a classroom situation
- These notes aren't finished yet

## The old Windows Command Shell

The traditional Windows command shell is a program called cmd.exe which can trace its roots all the way back to the old, pre-Windows DOS prompt.

You can launch this command shell as follows

- Hold down both the Windows button and the letter R to open the Run prompt
- Type cmd and press Enter or click OK

![Launch Cmd](./images/launchcmd.png)

- You should see a window similar to the one below

![Windows Command Prompt](./images/cmdexe.png)

The Windows command shell hasn’t changed significantly for over twenty years and is relatively feature poor compared to more modern shells.  For this reason, it is recommended that you use Windows PowerShell instead.  Mention of cmd.exe is only included here since, despite its deficiencies,  it is still widely in use

## PowerShell

To launch PowerShell:

- Hold down both the Windows button and the letter R to open the Run prompt
- Type **powershell** and press Enter or click OK

![Launch PowerShell](./images/launchpowershell.png)

- You should see a window similar to the one below

![PowerShell prompt](./images/powershell.png)

Note that although the header of the above window mentions v1.0, it could be a screenshot from either version 1.0 or version 2.0. This is a well-known bug.  If you are using Windows 7 you will have version 2 at the minimum.

##PowerShell versions
At the time of writing, PowerShell is at version 3.  Ideally, you should at least have version 2.0 installed.  To check version:

	$psversiontable.psversion

	Major  Minor  Build  Revision
	-----  -----  -----  --------
	3      0      -1     -1

If this variable does not exist, you are probably using version 1.0 and should upgrade.

Version 3.0 is available at [http://blogs.technet.com/b/heyscriptingguy/archive/2013/06/02/weekend-scripter-install-powershell-3-0-on-windows-7.aspx](http://blogs.technet.com/b/heyscriptingguy/archive/2013/06/02/weekend-scripter-install-powershell-3-0-on-windows-7.aspx?wa=wsignin1.0)

## Comments
	# This is a comment in Powershell. It is not executed

##Directories

Users of Bash will feel right at home at first since PowerShell appears to have the same set of commands

	pwd							#Path to current folder
	ls							#List directory
	ls *.txt					#Wild Card
    ls *_hai*
    ls -R   		            #Recursive folder listing
    ls .    		  			#List current folder
    ls ..   		 			#List Parent folder
    cd ..						#Change current folder to parent. (Move up a folder)
	cd ~    	  				#Change current folder to your user directory.
    mkdir myfolder		    	#Create a folder
	mkdir ~/myfolder	
	mv myfolder new_myfolder	#rename myfolder to new_myfolder
    rm -r new_myfolder			#Delete new_myfolder if its empty


# Files

    cat file           			# View file
    more file          			# Page through file
    cat file | select -first 3	# first N lines
    cat file | select -last 2   # Last N lines
    cp file1 file2     			# Copy
    cp *.txt directory
    rm file.txt        			# Delete - no recycle bin.
    rm -r directory    			# Recurse

##Different command types in PowerShell: Aliases, Functions and Cmdlets
Many of the PowerShell commands we've used so far are actually aliases to Powershell Cmdlets which have a Verb-Noun naming convention.  We can discover what each command is an alias of using the **get-alias** cmdlet.

	PS > get-alias ls
	
	CommandType     Name                                                Definition
	-----------     ----                                                ----------
	Alias           ls                                                  Get-ChildItem

This shows that **ls** is an alias for the Cmdlet **Get-ChildItem**

A list of aliases for common Bash commands:

- cat (Get-Content)
- cd (Set-Location)
- ls (Get-ChildItem)
- pwd (Get-Location)

Aliases were created to make PowerShell a more familiar environment for users of other shells such as the old Windows cmd.exe or Linux's Bash environment and also to save on typing.

You can get a list of all aliases using **get-alias** on its own.

	PS > get-alias

Finally, here's how you get all of the aliases for the **Get-ChildItem** cmdlet.

	get-alias | where-object {$_.Definition -match "Get-Childitem"}

For more details on Powershell aliases, see Microsoft's documentation at [http://technet.microsoft.com/en-us/library/ee692685.aspx](http://technet.microsoft.com/en-us/library/ee692685.aspx)

###What type of command is mkdir?
The **mkdir** command looks like it might be an alias as well since it doesn't have the verb-noun naming convention of Cmdlets.  Let's try to see which Cmdlet it might be an alias of:

	PS > get-alias mkdir
 
	Get-Alias : This command cannot find a matching alias because alias with name 'mkdir' do not exist. 
	At line:1 char:6
	+ alias <<<<  mkdir
    	+ CategoryInfo          : ObjectNotFound: (mkdir:String) [Get-Alias], ItemNotFoundException
    	+ FullyQualifiedErrorId : ItemNotFoundException,Microsoft.PowerShell.Commands.GetAliasCommand

It turns out that **mkdir** isn't an alias at all but is actually yet another PowerShell command type, a function.  We can see this by using the **get-command** Cmdlet
	
	PS > get-command mkdir
	CommandType     Name                                                Definition
	-----------     ----                                                ----------
	Function        mkdir                                               ...
	Application     mkdir.exe                                           C:\Program Files (x86)\Git\bin\mkdir.exe

Now we can clearly see that mkdir is a PowerShell function.  The mkdir.exe is an Application which you'll only see if you correctly installed git as per the Software Carpentry for Windows install instructions.

##Cmdlets
A Cmdlet (pronounced 'command-let') is a .NET class but you don't need to worry abut what this means until you get into advanced PowerShell usage.  Just think of Cmdlets as the base type of PowerShell command.  They are always named according to the convention **verb-noun**; for example **Set-Location** and **Get-ChildItem**.  

####Listing all Cmdlets
The following lists all Cmdlets

	Get-Command

You can pipe this list to a pager

	Get-Command | more

##Getting help
You can get help on any PowerShell command using the -? switch. For example

	ls -?

When you do this, you'll get help for the **Get-ChildItem** Cmdlet which would be confusing if you didn't know that ls is actually an alias for **Get-ChildItem**

## History

Up arrow browses previous commands.

By default, PowerShell version 2 remembers the last 64 commands whereas PowerShell version 3 remembers 4096.  This number is controlled by the $MaximumHistoryCount variable

	PS > $MaximumHistoryCount  			#Display the current value
 	PS > $MaximumHistoryCount=150 	 	#Change it to 150
	PS > history						#Display recent history using the alias version of the command
 	PS > get-history					#Display recent history using the Cmdlet direct
 
Although it remembers more, PowerShell only shows the last 32 commands by default.  To see a different number, use the count switch

	PS > get-history -count 50

To run the Nth command in the history use Invoke-History

	PS > invoke-history 7

##Word count (and more) using  Measure-Object

Linux has a command called **wc** that counts the number of lines and words in a file.  Powershell has no such command but we can do something similar with the **Measure-Object** Cmdlet.

Say we want to count the number of lines, words and characters in the file foo.txt.  The first step is to get the content of the file

    get-content foo.txt    				# gets the content of foo.txt

Next, we pipe the result of the get-content Cmdlet to Measure-Object, requesting lines, words and characters

	get-content foo.txt | measure-object -line -character -word

The measure-object Cmdlet can also count files

	ls *.txt | measure-object			#Counts number of .txt files in the current folder

When you execute the above command, a table of results will be returned:

	Count    : 3
	Average  :
	Sum      :
	Maximum  :
	Minimum  :
	Property :

This is because the measure-object Cmdlet, like all PowerShell Cmdlets, actually returns an object and the above table is the textual representation of that object.

This hints that **measure-object** can do a lot more than simply count things.  For example, here we find some statistics concerning the file lengths found by the ls *.txt command

	ls *.txt | measure-object -property length -minimum -maximum -sum -average

You may wonder exactly what type of object has been returned from measure-object and we can discover this by running the gettype() method of the returned object

	(ls *.txt | measure-object).gettype()

Request just the name as follows

	(ls *.txt | measure-object).gettype().Name

	GenericMeasureInfo

To find out what properties an object has, pass it to the **get-member** Cmdlet

	#Return all member types
	ls *.txt | get-member

	#Return only Properties
	ls *.txt | get-member -membertype property

Sometimes, you'll want to simply return the numerical value of an object's property and you do this using the **select-object** Cmdlet.  Here we ask for just the Count property of the GenericMeasureInfo object returned by **measure-object**.

	#Counts the number of *.txt files and returns just the numerical result
	ls *.txt | measure-object | select-object -expand Count

##Searching within files
The Unix world has **grep**, PowerShell has **Select String**

	Select-String the haiku.txt								#Case insensitive by default, unlike grep
	Select-String the haiku.txt -CaseSensitive				#Behaves more like grep
	Select-String day haiku.txt -CaseSensitive
	Select-String is haiku.txt -CaseSensitive
	Select-String 'it is' haiku.txt -Casesensitive

There is no direct equivalent to grep's -w switch.

	grep -w is haiku.txt 			#exact match

However, you can get the same behaviour using the word boundary anchors, **\b**

	Select-String \bis\b haiku.txt -casesensitive

Grep has a -v switch that shows all lines that do not match a pattern.  **Select-String** makes use of the **-notmatch** switch.

	BASH: grep -v "is" haiku.txxt
	PS: select-string -notmatch "is" haiku.txt -CaseSensitive

Grep has an -r switch which stands for 'recursive'.  The following will search through all files and subfolders of your current directory, looking for files that contain **is**

	grep -r is *

**Select-String** has no direct equivalent to this.  However, you can do the same thing by using get-childitem to get the list of files, piping the output to **select-string**

	get-childitem * -recurse | select-string is

One difference between **grep** and **Select-String** is that the latter includes the filename and line number of each match.

	grep the haiku.txt

	Is not the true Tao, until
	and the presence of absence:

	Select-String the haiku.txt -CaseSensitive

	haiku.txt:2:Is not the true Tao, until
	haiku.txt:6:and the presence of absence:  

To get the **grep**-like output, use the following

	Select-String the haiku.txt -CaseSensitive | ForEach-Object {$_.Line}

	Is not the true Tao, until
	and the presence of absence:

To understand how this works, you first have to know that **Select-String** returns an **array** of **MatchInfo** objects when there is more than one match.  To demonstrate this:

	$mymatches = Select-String the haiku.txt -CaseSensitive  #Put all matches in the variable 'mymatches'
	$mymatches -is [Array] 			#query if 'match' is an array

	True

So, mymatches is an array.  We can see how many elements it has using the array's Count property

	$mymatches.Count

	2

The type of elements in PowerShell arrays don't necessarily have to be the same.  In this case, however, they are.

	$mymatches[0].gettype() 
	$mymatches[1].gettype()

both of these give the output

	IsPublic IsSerial Name                                     BaseType
	-------- -------- ----                                     --------
	True     False    MatchInfo                                System.Object

If all you wanted was the name of the first object type, you'd do

	$mymatches[0].gettype().name

	MatchInfo

Alternatively, we could have asked for each element's type using the **For-Each-Object** Cmdlet to loop over every object in the array.

	$mymatches | Foreach-Object {$_.gettype().Name}

Where **$_** is a special variable that effectively means 'current object' or 'The object currently being considered by Foreach-Object' if you want to be more verbose.

So, we know that we have an array of 2 MatchInfo objects in our variable mymatches.  What does this mean?  What properties do MatchInfo objects have?  We can find out by piping one of them to the **Get-Member** Cmdlet.

	$mymatches[0] | Get-Member

	   TypeName: Microsoft.PowerShell.Commands.MatchInfo

	Name         MemberType Definition
	----         ---------- ----------	
	Equals       Method     bool Equals(System.Object obj)
	GetHashCode  Method     int GetHashCode()
	GetType      Method     type GetType()
	RelativePath Method     string RelativePath(string directory)
	ToString     Method     string ToString(), string ToString(string directory)
	Context      Property   Microsoft.PowerShell.Commands.MatchInfoContext Context {get;se
	Filename     Property   System.String Filename {get;}
	IgnoreCase   Property   System.Boolean IgnoreCase {get;set;}
	Line         Property   System.String Line {get;set;}	
	LineNumber   Property   System.Int32 LineNumber {get;set;}
	Matches      Property   System.Text.RegularExpressions.Match[] Matches {get;set;}
	Path         Property   System.String Path {get;set;}
	Pattern      Property   System.String Pattern {get;set;}	

Now we can see that each MatchInfo object has a Line property and it's reasonable to guess that this contains a Line containing a match.  Taking a look:

	$mymatches[0].Line

	Is not the true Tao, until

Bringing together everything we've seen so far, we pull out the Line property of each element in the array as follows
	
	$mymatches | Foreach-Object {$_.Line}

Alternatively, we can ditch the $mymatches variable and pipe in the output of **Select-String** directly

	Select-String the haiku.txt -CaseSensitive | ForEach-Object {$_.Line}

	Is not the true Tao, until
	and the presence of absence:

##Regular expressions

##Finding Files
    # Find all     
	UNIX: find .
	PS: get-childitem .  -Recurse | foreach-object {$_.FullName}    

To save on typing, you can use the alias **gci** instead of **get-childitem**
    
	# Directories only
	UNIX: find . -type d        
	PS2: gci . -recurse | where { $_.PSIsContainer }
	PS3: gci -recurse -Directory 

If you have PowerShell 2, you can only use the long winded version.  It's simpler in PowerShell 3.  Similarly for searching for files only.
	
	# Files only
	UNIX: find . -type f          
	PS2: get-childitem -recurse | where { ! $_.PSIsContainer }
	PS3: gci -recurse -File
    
With the Unix find command, you can specify the maximum and minimum search depths.  There is no direct equivalent in PowerShell although you could write a function that will do this.  Such a function can be found at [http://windows-powershell-scripts.blogspot.co.uk/2009/08/unix-linux-find-equivalent-in.html](http://windows-powershell-scripts.blogspot.co.uk/2009/08/unix-linux-find-equivalent-in.html) although **I have not tested this!**

	# Maximum depth of tree
	UNIX: find . -maxdepth 2
	PS : No direct equivalent
	# Minimum depth of tree
	UNIX: find . -mindepth 3 
	PS : No direct equivalent

You can also filter by name.  Confusingly, PowerShell offers two ways of doing this.  More details on the differences between these can be found at [http://tfl09.blogspot.co.uk/2012/02/get-childitem-and-theinclude-and-filter.html](http://tfl09.blogspot.co.uk/2012/02/get-childitem-and-theinclude-and-filter.html)

One key difference between find and get-childitem is that the latter is case-insenstive whereas find is case sensitive.
    
	# Find by name
    UNIX: find . -name '*.txt' 
	PS: gci -recurse -include *.txt
	PS: gci -recurse -filter *.txt

	#Find empty files
    UNIX: find . -empty    
	PS: gci -recurse | where ($_.Length -eq 0) | Select FullName 

	#Create empty file
    UNIX: touch emptyfile.txt
	PS: new-item emptyfile.txt -type file

##Command Substituion

In bash, you can execute a command using backticks and the result is substituted in place.  i.e.

	#bash
	foo `bar`

The backticks are used as escape characters in PowerShell so you do the folllowing instead

	#PS
	foo $(bar)

In both cases, the command **bar** is executed and result is substituted into the call to **foo**.	

## Input and output redirection

`>` redirects output (AKA standard output).  This works in both Bash and Powershell scripts.  For example, in Bash we might do

	#BASH
	grep -r not * > found_nots.txt

Drawing on what we've learned so far, you might write the PowerShell version of this command as

	#PS
	get-childitem *.txt -recurse | select-string not > found_nots.txt

However, if you do this, you will find that the script will run forever with the hard-disk chugging like crazy. If you've run the above command, **CTRL and C** will stop it. This is because Powershell is including the output file, found_nots.txt, in its input which leads to an infinite loop.  To prevent this, we must explicitly exclude the output file from the **get-childitem** search

	get-childitem *.txt -Exclude 'found_nots.txt' -recurse | select-string not > found_nots.txt

	cat found_nots.txt
    ls *.txt > txt_files.txt
    cat txt_files.txt

In Linux,  `<` redirects input (AKA standard input).  This does not work in PowerShell:

	cat < haiku.txt
	At line:1 char:5
	+ cat < haiku.txt
	+     ~
	The '<' operator is reserved for future use.
    	+ CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    	+ FullyQualifiedErrorId : RedirectionNotSupported

The above is a forced use of < since one could simply do

	cat haiku.txt

Recall that **cat** is an alias for **get-content**.  The use of **get-content** is an idiom that gets around the lack an < operator.  For example, instead of 

	foo < input.txt

One does
	
	get-content input.txt | foo

Error messages are output on standard error

    ls idontexist.txt > output.txt  
    cat output.txt					#output.txt is empty
    ls idontexist.txt 2> output.txt               # 2 is standard error
    ls haiku.txt 1> output.txt                    # 1 is standard output
    ls haiku.txt,test_file.txt 2>&1 > output.txt  # Combine the two streams.

##Exercise - Select-String
	
`pdb/` contains a set of protein database files

Each `.pdb` file lists atoms in a protein

Write a single command that

 - Uses `Select-String` to find all  hydrogen (`H`) atoms in all `.pdb` files.
 - Stores these in `hydrogen.txt`.

You will need wild card, exact matches output redirection

Problems with the solution?

 * Chains could be labelled with identifiers `H` and `L` (for heavy and light).
 * `AUTHOR` contains an initial e.g. `HARRY H CORBETT`.

Important:

 - Understand data.
 - Review script.
 - Validate that actual results equal expected results.

Here is a potential solution
	
	select-string '\bH\b' *.pdb > hydrogen.txt
 
## Variables

    get-variable                            # See all variables
    $MYFILE="data.txt"						# Need quotes around strings
    echo $MYFILE
    echo "My file name is $MYFILE"
	$num = 1								#Numbers don't need quotes
	$num = $num+1							#Simple Arithmetic
	$TEXT_FILES=get-childitem				Save output of get-childitem
	echo $TEXT_FILES

Variables only persist for the duration of the current PowerShell Session

## Environment variables

Windows environment variables don't show up when you execute `get-variable`; to list them all you do

	#PS
	get-childitem env:					#Show all Windows Environment variables 
	echo $env:PATH						#Show the contents of PATH
	$env:Path = $env:Path + ";C:\YourApp\bin\"	#temporarily add a folder to PATH

This modification to PATH will only last as long as the current session.  It is possible to permanently modify the system PATH but this should only be done with extreme care and is not covered here. 

## PowerShell Profile

The PowerShell profile is a script that is executed whenever you launch a new session.  Every user has their own profile.  The location of your PowerShell profile is defined by the variable **$profile**
	
	$profile

Open it with 

	notepad $profile

Add something to it such as 

	echo "Welcome to PowerShell.  This is a message from your profile"

Restart PowerShell and you should see the message.  You can use this profile to customise your PowerShell sessions.  For example, if you have installed NotePad++, you might find adding the following function to your PowerShell Profile to be useful.

	# Launch notepad++ using the npp command
	function npp($file)
	{
  	if ($file -eq $null)
    	{
    	    & "C:\Program Files (x86)\Notepad++\notepad++.exe";
    	}
    	else
    	{
        	& "C:\Program Files (x86)\Notepad++\notepad++.exe" $file;
    	}
	}