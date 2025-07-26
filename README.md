# Waste Emission Prediction System

## Data used
- **Dataset**: [What a Waste Dataset](https://www.kaggle.com/datasets/mannmann2/what-a-waste-global-dataset?resource=download)
- **Source**: Kaggle
- **Africanization**: The dataset has been modified to include only waste composition data relevant to African landfills by filtering African countries using the country_name field.

## Mission & Problem
**Problem**: Waste pollution is a major issue that accelerates climate change, harms our environment, and endangers wildlife. Many people don’t know how to properly dispose of their waste and have no clear, simple guidance on how to do so. As a result, recyclable and compostable waste often ends up in the wrong places, contributing to pollution

**Mission**: My mission is to drive sustainable environmental change by reducing waste pollution and promoting responsible disposal practices. Through technological innovation and awareness, I aim to protect wildlife, combat climate change, and empower communities to adopt eco-friendly habits that contribute to a cleaner and healthier planet.

## Solution Components
1. **Machine Learning Model**: Predicts methane emissions from landfill waste composition
2. **REST API**: Serves predictions to mobile and web applications
3. **Mobile App**: Provides user-friendly interface for emission predictions

## Technical Implementation

### API Endpoint
**Swagger UI**: [API Documentation](https://methane-emissions-from-landfill.onrender.com/docs#/)

### Repository Structure

├── linear-regression/ # Jupyter notebook with model development and prediction using best model
│   ├──multivariate.ipynb
│   └──predict.py
│
├── API/ # FastAPI implementation
│ ├── main.py
│ ├── requirements.txt
│ ├── prediction.py
│ ├── scaler.pkl
│ ├── waste_emission_model.pkl
│ └── selected_features.pkl
|
├── FlutterApp/waste_emition_predictor/ # Flutter implementation
│ ├── lib/
│ ├── pubspec.yaml
│ └── ...



## Demo Video
[![Watch the video]](https://www.loom.com/share/c67c688bb9be42fd894ad671016dbe94?sid=315e3126-8c3e-49ff-8fcf-cd192e0299d5)

## How to Run

### Flutter App
   ```bash
   cd FlutterApp/waste_emition_predictor
   flutter pub get
   flutter run
```

### API (Local Development)
bash
```bash
cd API
pip install -r requirements.txt
uvicorn main:app --reload
```

