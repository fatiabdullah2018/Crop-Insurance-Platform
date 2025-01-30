# Decentralized Crop Insurance Platform

A blockchain-based parametric insurance platform providing automated coverage for farmers against weather-related risks through smart contracts and real-time data integration.

## Overview

The platform combines blockchain technology with parametric insurance to protect farmers against crop failures and weather-related risks. It features automated policy issuance, transparent premium calculations, and instant claim settlements triggered by verified weather events.

## Core Features

### Parametric Insurance Engine
- Automated policy issuance and management
- Real-time premium calculations based on risk data
- Instant claim settlements triggered by weather events
- Transparent coverage terms and conditions
- Historical claim analytics

### Weather Data Integration
- Multi-source weather data aggregation
- Satellite imagery analysis
- Real-time condition monitoring
- Historical pattern analysis
- Automated risk assessment

### Smart Contract System
```solidity
contract CropInsurance {
    struct Policy {
        address farmer;
        uint256 coverageAmount;
        uint256 premium;
        uint256 startDate;
        uint256 endDate;
        bytes32 location;
        WeatherThresholds thresholds;
        bool active;
    }

    struct WeatherThresholds {
        uint256 minRainfall;
        uint256 maxRainfall;
        uint256 minTemperature;
        uint256 maxTemperature;
    }

    mapping(uint256 => Policy) public policies;
    mapping(address => uint256[]) public farmerPolicies;
}
```

## Technical Architecture

### Blockchain Layer
- Ethereum smart contracts for policy management
- Chainlink oracles for weather data feeds
- IPFS for documentation storage
- Polygon for scalable transactions

### Application Layer
- Node.js backend services
- React-based web interface
- Mobile-first farmer dashboard
- Analytics platform

## Getting Started

### Prerequisites
- Node.js v16+
- MongoDB v4.4+
- Ethereum wallet
- Weather API credentials

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-org/crop-insurance.git
cd crop-insurance
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Deploy contracts:
```bash
npx hardhat run scripts/deploy.js --network <network>
```

## Smart Contract Architecture

### PolicyFactory.sol
- Policy creation and management
- Premium calculation logic
- Claim verification rules

### WeatherOracle.sol
- Weather data integration
- Multiple data source aggregation
- Data verification logic

### ClaimProcessor.sol
- Automated claim assessment
- Payment processing
- Event logging

## API Documentation

### Policy Management
```
POST /api/policies/create
GET /api/policies/{id}
POST /api/policies/{id}/claim
GET /api/policies/status/{id}
```

### Weather Data
```
GET /api/weather/{location}
GET /api/satellite/{location}
GET /api/risk/assessment/{location}
```

## Risk Assessment Model

### Factors Analyzed
- Historical weather patterns
- Soil conditions
- Crop type
- Growth stage
- Location risk factors
- Previous claims history

### Risk Calculation
```python
def calculate_risk_score(params):
    weather_risk = assess_weather_patterns(params.location)
    soil_risk = assess_soil_conditions(params.soil_data)
    crop_risk = assess_crop_vulnerability(params.crop_type)
    
    return weighted_average([
        (weather_risk, 0.4),
        (soil_risk, 0.3),
        (crop_risk, 0.3)
    ])
```

## Security Features

### Smart Contract Security
- Multi-signature requirements
- Time-locked functions
- Emergency pause mechanism
- Regular audits

### Data Security
- Encrypted storage
- Access control
- Rate limiting
- Audit logging

## NFT Implementation

### PolicyNFT.sol
```solidity
contract PolicyNFT is ERC721 {
    struct PolicyMetadata {
        uint256 policyId;
        uint256 coverage;
        string location;
        uint256 startDate;
        uint256 endDate;
    }
    
    mapping(uint256 => PolicyMetadata) public policyMetadata;
}
```

## Development Roadmap

### Phase 1 - Core Platform (Q2 2025)
- Basic policy issuance
- Weather data integration
- Simple claim processing

### Phase 2 - Enhanced Features (Q3 2025)
- Mobile app launch
- Advanced risk assessment
- Multi-crop support

### Phase 3 - Expansion (Q4 2025)
- Cross-chain integration
- ML risk modeling
- Extended oracle network

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and development process.

## License

This project is licensed under the MIT License - see [LICENSE.md](LICENSE.md) for details.

## Support

- Documentation: [docs.crop-insurance.com](https://docs.crop-insurance.com)
- Email: support@crop-insurance.com
- Discord: [discord.crop-insurance.com](https://discord.crop-insurance.com)
