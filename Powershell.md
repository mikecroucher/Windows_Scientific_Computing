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

![Git Setup]("../images/launchcmd.png")

- You should see a window similar to the one below

![Windows Command Prompt]("./images/cmdexe.png")

The Windows command shell hasn’t changed significantly for over twenty years and is relatively feature poor compared to more modern shells.  For this reason, it is recommended that you use Windows PowerShell instead.  Mention of cmd.exe is only included here since, despite its deficiencies,  it is still widely in use

## PowerShell

To launch PowerShell:

- Hold down both the Windows button and the letter R to open the Run prompt
- Type **powershell** and press Enter or click OK

![Launch PowerShell]("./images/launchpowershell.png")

- You should see a window similar to the one below

![PowerShell prompt]("./images/powershell.png")


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

##Getting help
You can get help on any PowerShell command using the -? switch. For example

	ls -?

When you do this, you'll get help for the **Get-ChildItem** Cmdlet which would be confusing if you didn't know that ls is actually an alias for **Get-ChildItem**