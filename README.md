# myapp

E-commerce App

## Getting Started

This project is E-commerce App in flutter. The domain layer is organized in clean-architecture principles and there are tests for each usecase inside the features.
<img width="668" alt="passed" src="https://github.com/user-attachments/assets/e8255c1a-399e-45e6-ba58-ba67388a182d">
-----Data Layer Overview--------
Task 10 reorganizes the E-commerce's App Data layer. The data layer contains model currently and the model product_model_test in the tests folder.

Step 1: Folder Setup Organize the project structure according to Clean Architecture principles. Create the following folders in the lib directory:
core: Contains the shared core components, entities, and error handling logic. ✔️
features: Includes feature-specific modules. ✔️
features/product: This will be the main module for the Ecommerce feature. ✔️
test: Contains all the unit. ✔️
Step 2: Implement Models
Inside the features/ecommerce/data/models directory, create a Product_model.dart file. ✔️
Define the ProductModel class that mirrors the Product entity, and include conversion logic to and from JSON using fromJson and toJson methods. ✔️
Write unit tests for the ProductModel to ensure its correctness. ✔️
Step 3: Documentation
Update the project documentation to include information about architecture, data flow. ✔️
Ensure that the documentation is clear and comprehensive. ✔️
