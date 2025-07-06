✅ 1. Built a flexible structure for the task tracker
I implemented a l TaskTreckerView screen that lets the user switch between a table view (ProjectsTableView) and a kanban board (CardBoard), depending on the selected filter.


✅ 2. Created a table with dynamic columns
In ProjectsTableView, the user can add and remove columns with a click — making the table work similar to Notion or Airtable.
The columns are displayed horizontally in a ScrollView, and each row is built through a separate RowView.
✅ 3. Built a kanban board grouped by statuses
In CardBoard, i  implemented a kanban board where:
Horizontally arranged columns (TaskCardView) represent unique statuses (e.g., Planning, In Progress).


Inside each column, tasks are displayed as cards (CardView) stacked vertically.


Each TaskCardView manages the list of cards for its specific status.


✅ 4. Added user-driven creation actions
In ProjectsTableView, the user can add new columns.
In TaskCardView, the user can add new cards for a specific status.
This gives the user flexibility to expand the content directly from the UI.

![Uploading Знімок екрана 2025-07-06 о 22.17.04.png…]()
![Uploading Знімок екрана 2025-07-05 о 02.46.11.png…]()
![Uploading Знімок екрана 2025-07-06 о 22.17.37.png…]()


