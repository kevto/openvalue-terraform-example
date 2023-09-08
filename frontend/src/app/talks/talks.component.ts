import {Component, OnInit} from '@angular/core';
import {ApiService} from "../api.service";
import {Observable} from "rxjs";
import {Talk} from "../models";

@Component({
  selector: 'talks',
  templateUrl: './talks.component.html',
  styleUrls: ['./talks.component.sass']
})
export class TalksComponent implements OnInit {

  talks$: Observable<Talk[]>
  constructor(private api: ApiService) {
    this.talks$ = api.talks$;
  }

  ngOnInit() {
    this.getTalks();
  }

  getTalks() {
    return this.api.getTalks()
  }


}
