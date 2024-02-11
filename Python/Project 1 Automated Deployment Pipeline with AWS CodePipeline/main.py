from flask import Flask

app = Flask(__name__)

class Tools:
    name_car = []
    tyres = 4
    brand = "Toyota"

    def carTyres(self):
        if self.tyres == 4:
            self.name_car.append(self.brand)
            return self.name_car[0]
        else:
            return "No 4 wheelers car in the list"

@app.route('/')
def get_car_brand():
    toyota_instance = Tools()
    toyota_car = toyota_instance.carTyres()
    return f'Toyota car brand: {toyota_car}'

if __name__ == '__main__':
    app.run()
