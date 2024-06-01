# Surveys Daatabase System

## Tables and Structure

### answer

- Columns:
  - id: Primary key.
  - answer_date: Timestamp of when the answer was submitted.
  - value: The actual answer given.
  - option_id: Foreign key referencing option(id).
  - filling_questionary_id: Foreign key referencing filling_questionaries(id).
- Constraints:
  - Primary key on id.
  - Foreign keys on option_id and filling_questionary_id.

### creator

#### Columns:
- login: Primary key, unique identifier for the creator.
- password: Password for the creator.
- name: Name of the creator.
- summary: A brief summary about the creator.
#### Constraints:
- Primary key on login.

### filling_questionaries

#### Columns:
- id: Primary key.
- start_time: Timestamp when the survey was started.
- end_time: Timestamp when the survey was finished (nullable).
- points: Points scored in the survey (nullable).
- user_login: Foreign key referencing user(login).
- questionary_id: Foreign key referencing questionary(id).
#### Constraints:
- Primary key on id.
- Foreign keys on user_login and questionary_id.

### option

#### Columns:
- id: Primary key.
- value: The text value of the option.
- is_correct: Boolean indicating if the option is correct.
- is_editable: Boolean indicating if the option is editable.
- question_id: Foreign key referencing question(id).
#### Constraints:
- Primary key on id.
- Foreign key on question_id.

### question

#### Columns:
- id: Primary key.
- name: The name or title of the question.
- description: Detailed description of the question (nullable).
- is_obligatory: Boolean indicating if the question is obligatory.
- questionary_id: Foreign key referencing questionary(id).
- question_type_name: Foreign key referencing question_type(name).
#### Constraints:
- Primary key on id.
- Foreign keys on questionary_id and question_type_name.

### questionary

#### Columns:
- id: Primary key.
- name: The name of the survey.
- description: Detailed description of the survey (nullable).
- create_date: Timestamp of when the survey was created.
- category: The category of the survey (nullable).
- creator_id: Foreign key referencing creator(login).
#### Constraints:
- Primary key on id.
- Foreign key on creator_id.

### question_type

#### Columns:
- name: Primary key, unique name of the question type.
#### Constraints:
- Primary key on name.

### user

#### Columns:
- login: Primary key, unique identifier for the user.
- password: Password for the user.
- name: Name of the user.
- summary: A brief summary about the user.
#### Constraints:
- Primary key on login.

## Indices
- Indices are created on foreign keys for performance optimization.
- Primary keys are defined for each table to uniquely identify records.
  
## Auto-increment
- id columns in answer, filling_questionaries, option, question, and questionary tables are set to auto-increment for unique identification.
  
## Constraints
Foreign key constraints ensure referential integrity between tables:
- answer references option and filling_questionaries.
- filling_questionaries references questionary and user.
- option references question.
- question references questionary and question_type.
- questionary references creator.
