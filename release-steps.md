2022-12-15, Release Steps for ooRexx 5.0.0 as a role model
===

- create a branch for `5.0.0` using current trunk (if no show stopper errors occur
  running the ooRexx testsuite) for
      `main/trunk` to `main/branches` and
      `test/trunk` to `test/branches`,
      not yet for the docs (see below)

  here the svn command for code and test (replace "userId" with yours)

      svn copy --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/main/trunk svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/main/branches/5.0.0  -m "Creating code branch 5.0.0 to prepare release."
      svn copy --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/test/trunk svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/test/branches/5.0.0 -m "Creating test branch 5.0.0 to prepare release."

- update the ooRexx version related information in trunk to `5.1.0`

  cf. <https://sourceforge.net/p/oorexx/code-0/12539/#diff-1> changes to:

      main/trunk/CMakeLists.txt   -- update the release version information to the next release.
      main/trunk/platform/windows/rexx32.exe.manifest
      main/trunk/platform/windows/rexx64.exe.manifest

  and cf. <http://sourceforge.net/p/oorexx/code-0/12540>

      main/trunk/api/oorexxapi.h  -- Add a new version identifier define for the new release.

- *before* creating the docs `branches/5.0.0`, the necessary steps:

  - make sure all authors who have committed in the meantime are listed in their appropriate
    `${book}/en-US/Author_Group.xml`; to detect one can use `tools/listAuthorsAsOfLate.rex`

  - make sure that `${book}/revision_info.txt` has the latest revision information
    of real updates to `${book}/en-US/*.xml` files; one approach to update that file
    is to first delete it, then run `updateEntityValues.rex -y 2022 -e "2022.12.25" -r 99999 ..`
    which will recreate `${book}/revision_info.txt`

  - make sure that all copyright texts are updated (you can use `tools/updateCopyright.rex`)

  - *NOTE:* copyright of `main/branches/5.0.0/ReleaseNotes` needs to be adjusted as well!

- create the docs branch for `5.0.0` using current `docs/trunk` to `docs/branches/5.0.0`

  here the svn command for code, documentation and test (replace "userId" with yours)

      svn copy --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/docs/trunk svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/docs/branches/5.0.0 -m "Creating docs branch 5.0.0 to prepare release."

- Suggestion for a time table:

    - t0: if the tests on Jenkins show no show-stopper errors from the latest trunk, then create the branch: ASAP

    - t1: apply the necessary changes in the branch (version information update, release information update):  < =(t0+7 days)

    - t2: create the installation packages from the branch and upload them to a staged directory `5.0.0`: after a week (t1+1)

    - t3: communicate the availability: t2+1

- create the following directories in files area on Sourceforge:

      oorexx/files/5.1.0beta        ... to receive the new builds from trunk
      oorexx/oorexx-docs/5.1.0beta  ... to receive the new documentation from trunk

      oorexx/files/5.0.0_Release_Candidate        ... to receive the tested builds from branches/5.0.0
      oorexx/oorexx-docs/5.0.0_Release_Candidate  ... to receive the new documentation from trunk

- adjust the build scripts on Jenkins and feed the `5.0.0_Release_Candidate` and the `5.1.0beta` folders
  for code and documentation

- release information:

  - update `branches/5.0.0/NOTICES` (a text file) to reflect the current copyright year

  - update `branches/5.0.0./CHANGES` (a text file) to document all changes from the last release for

       - Bugs
       - Feature-requests
       - Documentation
       - Patches

    1) all items with the status `accepted` need to be checked to see whether they
       have been worked on such that they can be changed to `pending`.
       `accepted` generally means code changes have been made, so these should be
       included in the changes.

       A decision needs to be made on whether the incomplete portions of the item
       (generally doc or test work) need to be completed prior to the release.

    2) all items with the status `pending` and `accepted` get included in `CHANGES`
       (the text file located in trunk), the script

       `main/trunk/support/sourceForge/processedTickets.rex`

       queries the four categories on SourceForge and creates the text for the entries
       to be added to `CHANGES`

    3) change all tickets with the status `pending` and `accepted` with no pending work items
       to `closed` using `bulk-edit`:

       - for each ticket category choose `Searches` in the left column towards the bottom

       - search/query for `pending` tickets, enter the following value in the search field:

         * category: Bugs, Feature-requests

               status:pending or (status:accepted AND _pending_work_items:none)

         * category: Documentation, Patches

               status:pending or status:accepted

       - if there are more than 25 hits, choose the maximum of 250

       - in the upper right hand corner choose `bulk-edit`

         - change status to `closed`

         - click the check box in the title underneath to select all tickets

         - click `Save`

     - repeat, if more than 250 hits

    4) a `Milestone` `5.1.0` and `5.0.1` (for potential buf fix releases) needs to be
       created, here the steps needed for `Bugs`:

       - pick `Administration`

       - click on the lock icon in the upper hand corner

       - click on the `Tickets` menu and then on the changed config "icon"
         left of the text `Bugs`

       - choose `Field Management`

       - add `5.1.0` and `5.0.1` to `Milestones` which represents ooRexx
         version numbers offered when new bugs get created; to take effect
         one needs to press the `Save` button underneath the visual frame

         *Note:* this option page would allow to delete Milestones (e.g. if no
             no tickets registered) and to declare Milestones to be "completed"
             by checking the respective box; deleted and completed Milestones
             will cause them to not be shown in the "Groups" frame on the left
             hand side.

- release

  - rename the folders from `5.0.0_Release_Candidate` to `5.0.0`

  - Update the SourceForge default download links to point to the new releases

  - announce the new release on the ooRexx related e-mail lists,
    RexxLA e-mail list, BSF4ooRexx related e-mail lists, Open Object Rexx Facebook page,
    comp.lang.rexx

    - ask the reader to forward the announcement to related e-mail lists
      they participate (like the various IBM e-mail lists, other related
      open-source e-mail lists and projects)

  - add a release entry in the SourceForge project's "News" section using
    the link: <https://sourceforge.net/p/oorexx/news/>

  - use "svn move" to move `main/branches/5.0.0` to `main/releases/5.0.0`, do the same
    for the documentation (`docs/branches/5.0.0` to `docs/releases/5.0.0`) and tests

        svn move --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/main/branches/5.0.0 svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/main/releases/5.0.0 -m "Creating main/releases/5.0.0 to conclude release process."
        svn move --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/docs/branches/5.0.0 svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/docs/releases/5.0.0 -m "Creating docs/releases/5.0.0 to conclude release process."
        svn move --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/test/branches/5.0.0 svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/test/releases/5.0.0 -m "Creating test/releases/5.0.0 to conclude release process."

  - change into docs/trunk/tools and run

        updateEntityValues.rex -y 2023 -v "5.0.0 -> 5.1.0" -e "2023.01.01" -r 99999 ..

  - update the ooRexx documentation in trunk to not show *CHG* and *NEW* for 50 anymore by
    setting the replacement text to the empty string `""`, from

        <!ENTITY added50 "*NEW* ">
        <!ENTITY changed50 "*CHG* ">
    to
        <!ENTITY added50 "">
        <!ENTITY changed50 "">

    and to add for new additions and changes in the documentation

        <!ENTITY added51 " *NEW* ">
        <!ENTITY changed51 " *CHG* ">

    in the files: `rexxapi/en-US/rexxapi.ent`, `rexxpg/en-US/rexxpg.ent`, `rexxref/en-US/rexxref.ent`,
    `winextensions/en-US/winextensions.ent`

  - change into main/trunk, edit CHANGES to remove all changes documented for
    5.0.0, keep the headings

  - change into `main/trunk`, edit `ReleaseNotes` to remove all changes documented for
    5.0.0, adjust copyright year and version (change from `5.0.0` to `5.1.0` and
    `4.2.0` to `5.0.0`)

- overall timetable estimate:

  - t0: if the tests on Jenkins show no show-stopper errors from the latest
        trunk, then create the branch

  - t1: create the installation packages from the branch and upload them to a
        staged directory `5.0.0`

  - t2: apply the necessary changes in the branch (version information update,
        release information update): within (t0+7) days the longest

  - t3: communicate the availability: t2+1

  - t4: once the release has been finalized, create a x.x.(n+1) branch from the release branche
        to be used for potential bug fix releases. This includes updating the release number information
        in the build.
        move the `main|docs|test"/branches/5.0.0` to `main|docs|test"/releases/5.0.0`

- in the case that updates are needed to the release version one needs to create
  appropriate the branches: `branches/5.0.1` for `main`, `docs`, `test` to work in

        svn copy --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/main/releases/5.0.0 svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/main/branches/5.0.1 -m "Creating code branch 5.0.1."
        svn copy --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/docs/releases/5.0.0 svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/docs/branches/5.0.1 -m "Creating docs branch 5.0.1."
        svn copy --username=userId svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/test/releases/5.0.0 svn+ssh://orexx@svn.code.sf.net/p/oorexx/code-0/test/branches/5.0.1 -m "Creating test branch 5.0.1."


----
Helpful SourceForge resources:

- SourceForge Documentation Home:   <https://sourceforge.net/p/forge/documentation/Docs%20Home/>

- Release API:          <https://sourceforge.net/p/forge/documentation/Using%20the%20Release%20API/>

- Bulk-edit of Tickets: <https://sourceforge.net/p/forge/documentation/Tickets/#bulk-edit>

- Markdown Syntax:      <https://sourceforge.net/nf/markdown_syntax>

- Very nice and helpful introduction to SourceForge setup, including "howto" backing up:
  <https://www.software.ac.uk/resources/guides/how-create-and-manage-sourceforge-projects>



------------

Changes to be made to Jenkins

For all Build jobs (31 2022-12-16)

Change Build Repository URL from trunk

https://svn.code.sf.net/p/oorexx/code-0/main/trunk

to Release Candidate

https://svn.code.sf.net/p/oorexx/code-0/main/branches/5.0.0

 ooRexx-CentOS9-build
 ooRexx-Controller-Ubuntu20-build
 ooRexx-Debian11-build
 ooRexx-Fedora35-build
 ooRexx-FreeBSD13-build
 ooRexx-linux-aarch64-build
 ooRexx-LinuxMint20-build
 ooRexx-macOS10-build
 ooRexx-macOS11-build
 ooRexx-macOS12-build
 ooRexx-macOS12-M1-build
 ooRexx-NetBSD9-build
 ooRexx-OpenBSD7_1-build
 ooRexx-OpenIndiana-build
 ooRexx-OpenSuse15-build
 ooRexx-RaspberryPiOS32-build
 ooRexx-RaspberryPiOS64-build
 oorexx-ubuntu16-build
 oorexx-ubuntu16debug-build
 ooRexx-Ubuntu22-build
 ooRexx-windows10_32-build
 ooRexx-windows10_64-build
 ooRexx-windows11_32-build
 ooRexx-windows11_64-build
 ooRexx-windows32-build 19
 ooRexx-windows64-build 20
 ooRexx-windows7_32-build
 ooRexx-windows7_64-build
 ooRexx-windows8_32-build
 ooRexx-windows8_64-build
 ooRexx-Z-build

For all Test jobs (29 2022-12-16)

Change Test Repository URL from trunk

https://svn.code.sf.net/p/oorexx/code-0/test/trunk

to Release Candidate

https://svn.code.sf.net/p/oorexx/code-0/test/branches/5.0.0

 ooRexx-CentOS9-test
 ooRexx-Controller-Ubuntu20-test
 ooRexx-Debian11-test
 ooRexx-Fedora35-test
 ooRexx-FreeBSD13-test
 ooRexx-LinuxMint20-test
 ooRexx-macOS10-test
 ooRexx-macOS11-test
 ooRexx-macOS12-M1-test
 ooRexx-macOS12-test
 ooRexx-NetBSD9-test
 ooRexx-OpenBSD7_1-test
 ooRexx-OpenIndiana-test
 ooRexx-OpenSuse15-test
 ooRexx-RaspberryPiOS32-test
 ooRexx-RaspberryPiOS64-test
 oorexx-ubuntu16-test
 ooRexx-Ubuntu22-test
 ooRexx-windows10_32-test
 ooRexx-windows10_64-test
 ooRexx-windows11_32-test
 ooRexx-windows11_64-test
 ooRexx-windows32-test
 ooRexx-windows64-test
 ooRexx-windows7_32-test
 ooRexx-windows7_64-test
 ooRexx-windows8_32-test
 ooRexx-windows8_64-test
 ooRexx-Z-test


in ooRexx-docs-build

change the Documentation Repository URL from trunk

https://svn.code.sf.net/p/oorexx/code-0/docs/trunk

to the release candidate

https://svn.code.sf.net/p/oorexx/code-0/docs/branches/5.0.0

Currently the upload of docs go to (two folders, PDF and html)

/oorexx-docs/5.0.0beta'
/oorexx-docs/5.0.0html'

Changed to  (PDF currently)

 oorexx-docs/5.0.0_Release_Candidate (staged)

ooRexx-{sourceforge-upload}

Currently the upload of  artifacts go to

sourceforgeFiles = "/home/frs/project/oorexx/oorexx/5.0.0beta"

CHANGED TO oorexx/5.0.0_Release_Candidate (staged) in the upload script but this is not sufficient -> There was a delay problem, is working as intended after some time

in jenkinsArtifactUpload.rex in /var/lib/jenkins/workspace/ooRexx-{sourceforge-upload}

The following artifacts are selected for upload (we might remove some of these):
ooRexx-CentOS9-build
ooRexx-Debian11-build
ooRexx-Fedora35-build
ooRexx-FreeBSD13-build
ooRexx-linux-aarch64-build
ooRexx-LinuxMint20-build
ooRexx-macOS11-build
ooRexx-macOS12-build
ooRexx-NetBSD9-build
ooRexx-OpenBSD7_1-build
ooRexx-OpenIndiana-build
ooRexx-OpenSuse15-build
ooRexx-RaspberryPiOS32-build
ooRexx-RaspberryPiOS64-build
oorexx-ubuntu16-build
oorexx-ubuntu16debug-build
ooRexx-Controller-Ubuntu20-build
ooRexx-Ubuntu22-build
ooRexx-windows32-build
ooRexx-windows64-build
ooRexx-Z-build

------------

Before any new release go through the tools used for documentation build to make sure they are still up to date; make any changes BEFORE a specific version is frozen to avoid double copying to release and trunk

Same for all platforms that we are currently building, work through all build and test "Projects" on Jenkins and note any build that fail (and the reason therefor) and any tests that are excluded (with a hint to a bug report if available)

------------

In order to get the correct documentation added to Windows and macOS installers it is imperative to build the documentation BEFORE the final build of code is triggered. The documentation need around one hour to complete when all documents are built so withing that time no build of code should be triggered.

A better way to do the release would possibly be to NOT change anything on Jenkins but leave the builds from trunk and then when it is agreed to release a specific revision to manually copy that revision on sourceforge using sftp. The burst of activity AFTER the agreement to go GA caused a lof of additional work, all that should be done in trunk

------------

TODO List for ooRexx 5 after a release is done

After release Jenkins shold go back to trunk

For Build Projects change

https://svn.code.sf.net/p/oorexx/code-0/main/branches/5.0.0
TO
https://svn.code.sf.net/p/oorexx/code-0/main/trunk

For Test Projects change

https://svn.code.sf.net/p/oorexx/code-0/test/branches/5.0.0

to

https://svn.code.sf.net/p/oorexx/code-0/test/trunk

Change Jenkins upload go to oorexx/5.1.0beta/ -> in Uploading script

Change Jenkins doc upload go to oorexx-docs/5.1.0beta/ -> in Docbuild Project

Set Windows  & MacOS to build only AFTER documentation has been built

Try to make sure everything is driven from CMake

Problem 1:
For Windows build currently the url for downloading the documentation is hardcoded in downloaddocs.bat (C:/downloaddocs/downloaddocs.bat)

Proposed solution: Make url an input to the script -> %1 (there are other input)
Preferably the url should come out of CMakeLists.txt
Temporary solution: still hardcoded but reading from oorexx-docs/5.0.0 (later 5.1.0beta)

Problem 2:
For MacOS build there is a script created at build time that is used post-build to create the installer. Also in this script the downloadpath for documentation is hardcoded

Proposed solution: Define a variable defining the downloadpath for documentation in CMakelists.txt that can be used in the script
Temporary solution: still hardcoded but reading from oorexx-docs/5.0.0 (later 5.1.0beta)

Problem 3:
oorexx-docs-bildutils folder on sourceforge is not automatically updated.

Temporary solution: use SFTP to upload the latest tools
Long term solution: check if this can be made a "Project" in Jenkins

Problem 4:
oorexx-buildutils is also not automatically updated. Further only Windows tools are present.

Temporary solution: use SFTP to upload the latest tools
Long term solution: a "Project" in Jenkins + Further tools for macOS and Linux/Unix

Problem 5:
In oorexx-docs/5.0.0 folder on SF the Readme.txt is missing

Solution: create a Readme.txt and try to set date to release date 2022-12-23

Problem 6:
In oorexx-docs/5.0.0 folder on SF the Readme.txt is not displayed ( a link to another document is not shown)

Solution fix the link

Problem 7:
oorexx-docs/5.0.0beta documentation is still present
Solved: Remove folder after having backed it up
(but 4.1 and earlier documentation is still missing)

Problem 8:
oorexx/5.0.0_Release_Candidate is still present
Solved: folder removed after having backed it up

Problem 9:
oorexx/5.0.0beta is still present
Solved: folder removed after having backed it up

Further problems found 2022-12-28

On several *nix platforms the installer build is tested after build

sudo rpm --upgrade ooRexx-5.0.0-*.rpm || true
rpm --query --info "ooRexx-5.0.0-*"
sudo rpm --erase "ooRexx-5.0.0-*"
sudo rpm --install ooRexx-5.0.0-*.rpm

Problem 1: all these settings must be manually edited.
Problem 2: testing the upgrade option is a good thing but at a change from 5.0.0 to 5.1.0 this will not succeed, the error will look like this

CPack: Create package
CPackRPM: Will use GENERATED spec file: /home/osboxes/workspace/ooRexx-CentOS9-build/oorexxBuild/_CPack_Packages/Linux/RPM/SPECS/ooRexx.spec
CPack: - package: /home/osboxes/workspace/ooRexx-CentOS9-build/oorexxBuild/ooRexx-5.1.0-12588.centos9.x86_64.rpm generated.
+ pkill rxapi
+ sudo rpm --upgrade ooRexx-5.1.0-12588.centos9.x86_64.rpm
	package ooRexx-5.0.1-12588.x86_64 is already installed
+ true
+ rpm --query --info 'ooRexx-5.1.0-*'
package ooRexx-5.1.0-* is not installed
Build step 'Execute shell' marked build as failure
Archiving artifacts
Finished: FAILURE

Hence the old 5.0.0 (5.0.1?) must be deleted manually.

Problem 3: in the uploading script there is a ::constant ooRexxID defined as '5.0.0-'
This must also be manually changed at a change from 5.0.0 -> 5.1.0

Short term solution to 1: Manually editing every script and changing 5.0.0 -> 5.1.0 (DONE)
Long term solution: make the naming of the installer from a variable read, preferably from CMakeLists.txt

Solution to 2: Manually visiting all *nix platforms and uninstalling earlier versions of oorexx; avoid using the "update" option in testing the installer; In the build process install artifact once query info and uninstall it before leaving (the test job is done from the built ooRexx, not the installed ooRexx)

Short term solution to 3: manually editing uploading script
Long term solution: read a variable  during upload rather than using a constant

----

Consider one additional zipped documentation item with the complete documentation available for download

The release version should not display the revision number. -> find out how to achieve this.

Revision numbers are part of the installer filenames (controlled by CMake) -> find out how to achieve this

----

