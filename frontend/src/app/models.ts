export class Talk {
  id?: number;
  speaker?: string
  title?: string
  description?: string
  constructor(obj?: any) {
    Object.assign(this, obj);
  }
}

export class Vote {
  id?: string;
  value?: number
  talkId?: number
  constructor(obj?: any) {
    Object.assign(this, obj);
  }
}
