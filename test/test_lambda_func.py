from src.lambda_func import lambda_handler
from unittest.mock import patch
import pytest

# Test for Task 1
@patch("src.lambda_func.random.randint", return_value=3)
def test_randint_is_used_to_mock_dice_roll(mock_random):
    event = {
        "dice_type": "d20",
        "dice_count": 1
    }
    result = lambda_handler(event, {})
    assert result == {'dice_count': [3]}

# Test for Task 2
#@pytest.mark.skip
@patch("src.lambda_func.random.randint", return_value=3)
def test_lambda_uses_event_to_calculate_dice_rolls(mock_random):
    event = {
        "dice_type": "d20",
        "dice_count": 2
    }
    result = lambda_handler(event, {})
    assert result == {'dice_count': [3, 3]}

# Test for Task 2
#@pytest.mark.skip
@patch("src.lambda_func.random.randint", return_value=2)
def test_lambda_uses_event_to_calculate_multiple_dice_rolls(mock_random):
    event = {
        "dice_type": "d12",
        "dice_count": 4
    }
    result = lambda_handler(event, {})
    assert result == {'dice_count': [2, 2, 2, 2]}
