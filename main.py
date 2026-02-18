import sys


def main():
    level = sys.argv[1] if len(sys.argv) > 1 else "beginner"

    match level:
        case "beginner":
            from beginner.runner import Beginner

            Beginner.run()
        case "intermediate":
            raise NotImplementedError("Intermediate not yet implemented")
        case "advanced":
            raise NotImplementedError("Advanced not yet implemented")
        case _:
            raise Exception(f"Unknown level: {level}")


if __name__ == "__main__":
    main()
