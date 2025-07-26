import joblib
import pandas as pd
import os
from pathlib import Path

# Try to load model, scaler, and selected features
try:
    model = joblib.load('waste_emission_model.pkl')
    scaler = joblib.load('scaler.pkl')
    features = joblib.load('selected_features.pkl')
    print("Model files loaded successfully!")
except FileNotFoundError as e:
    print(f"Error loading model files: {e}")
    print("Please ensure the following files are in the current directory:")
    print("- waste_emission_model.pkl")
    print("- scaler.pkl") 
    print("- selected_features.pkl")
    model = None
    scaler = None
    features = None

def predict_emission(organic_waste, population, gdp_per_capita, landfill, waste_per_capita):
    # Check if model files are loaded
    if model is None or scaler is None or features is None:
        raise ValueError("Model files are not loaded. Please ensure all required .pkl files are present.")
    
    input_dict = {
        'composition_food_organic_waste_percent': organic_waste,
        'population_population_number_of_people': population,
        'gdp': gdp_per_capita,
        'waste_treatment_landfill_unspecified_percent': landfill,
        'waste_generation_per_capita_kg_per_person_per_day': waste_per_capita
    }

    df = pd.DataFrame([input_dict])
    df = df[features]
    scaled = scaler.transform(df)

    return model.predict(scaled)[0]
