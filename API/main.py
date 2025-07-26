from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from prediction import predict_emission

app = FastAPI(
    title="Waste Emission Predictor",
    description="Predict methane emissions from waste and economic data",
    version="1.0.0"
)

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Request model using Pydantic
class EmissionInput(BaseModel):
    organic_waste: float = Field(..., ge=0, le=100, description="Percentage of food/organic waste (0-100)")
    population: int = Field(..., ge=1, description="Total population (must be at least 1)")
    gdp_per_capita: float = Field(..., ge=0, description="GDP per capita (USD)")
    landfill: float = Field(..., ge=0, le=100, description="Percentage of landfill usage (0-100)")
    waste_per_capita: float = Field(..., ge=0, le=10, description="Waste generated per person per day (kg)")

# POST endpoint
@app.post("/predict")
def predict(input: EmissionInput):
    try:
        prediction = predict_emission(
            organic_waste=input.organic_waste,
            population=input.population,
            gdp_per_capita=input.gdp_per_capita,
            landfill=input.landfill,
            waste_per_capita=input.waste_per_capita
        )
        return {"predicted_emission": prediction}
    except ValueError as e:
        raise HTTPException(status_code=500, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")
