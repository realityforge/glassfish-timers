# Tide

[Tide](http://stocksoftware.com.au/tide) is a web application developed by Stock Software to collect employee's
timesheets for invoicing and payroll.

It can be found here: [http://stocksoftware.com.au/tide](http://stocksoftware.com.au/tide)

## Creating a new account

Ask a director to create your account... it has to be done with a database insert :)

## Filling out your timesheet

On the timesheet page, you should enter all the time you work and leave you take.

We'd like you to fill this out at the end of every day, but at the very least, complete it once per week.

### Enter your working hours

For each day you can select a project from the dropdown and enter the number of hours. There is also an optional field for
additional comments. Once entered, click the Save button in the top right.

If you're not sure which project to put time against, ask a director.

If you worked on multiple projects on one day, click Save and then the plus button on the end of the row to add an extra project line.

**NOTE: Clicking the plus button will refresh the page, so always click Save first.**

### Entering leave

There are a number of projects for leave starting with "z", such as "zAnnual Leave", "zSick Leave", "zPublic Holiday"
etc. A day of leave must be entered as 8 hours.

### In-house

You can use the "zIn-house" project when you are doing non client related activities such as retros, writing way-of-stock
documentation or training.

## Adding a new project

You can add a new project by going to the Project Administration page, but discuss this with a director first.

At the top of the page, enter a Name (being consistent with the other names), tick the Billable and Working boxes,
and click the Create button.

## Project cloaking

The list of projects is quite large, so you'll want to cloak the ones in which you are not interested. By default,
when a new project is created, it will be uncloaked, and will appear in your list.

To cloak a project, go to the Projects Administration page, find the project in the Project Cloaking table, tick
the Cloaked tick box, and click Save at the bottom of the table.

## DELWP Duty officer

Those people who are working as Duty Officers for DELWP need to enter their work as follows:

For normal working days only the night work needs to be recorded.  You should record nights as 'DELWP D/O Night', with a value of 1.

For weekends and public holidays both the day work and the night work needs to be recorded.
You should record the night as 'DELWP D/O Night', with a value of 1, and the day as 'DELWP D/O Day', with a value of 1.

If you are activated then this should be recorded as an additional entry of 'IRIS Standby Activated', the value should be the number of hours, with a comment describing the SRQ.

Note that activation MUST be done in consultation with Fireweb Level 1 support.  If anyone else askes you to do work then you direct them to Fireweb Support.
Answering the phone, discussing a problem, and tracking down someone to do the work is not an activiation.  An activation requires you to be actually working on a PC to fix a problem.
